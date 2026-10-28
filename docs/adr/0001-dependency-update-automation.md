# ADR 0001: Dependabot と依存更新の自動化

- Status: Accepted
- Date: 2026-10-28
- Author: @gtn-74

## 決定

- `mac/flake.lock` は `update-flake-lock` アクションで週次に更新 PR を作る（`.github/workflows/update-flake-lock.yml`）
- 更新 PR には `nix flake check` と darwin 構成のビルドを走らせ、マージは手動で行う（`.github/workflows/nix-check.yml`）
- リポジトリが public なので Dependabot の `nix` ecosystem も併用する。あわせて GitHub Actions 自体の更新も Dependabot に任せる（`.github/dependabot.yml`）
- Nix 管理ツールの CVE は Dependabot alerts では検知できない。nixpkgs を前へ進め続けることで取り込む

以下は判断の根拠となった調査メモ（引き継ぎ書）。

## Dependabot は2つの別機能

「Dependabot が入っている／入っていない」の正体は、名前が同じで仕組みの違う2つの機能が混在していること。

| 機能 | 起動条件 | いつ動くか | 何をするか |
| --- | --- | --- | --- |
| Dependabot alerts / security updates | GitHub 側の設定でオン | 脆弱性が公開された時点で即座に | 修正済みの最小バージョンへ上げる PR + アラート |
| Dependabot version updates | `.github/dependabot.yml` がある | schedule の間隔（weekly など） | 新しいバージョンが出たら上げる PR |

身に覚えなく有効になっている主な理由は3つ。

1. アカウントまたは Organization の Settings → Code security に「新規リポジトリで自動的に有効化」があり、オンにした**後に作ったリポジトリだけ**で alerts が有効になる。ある時期以降のリポジトリにだけ入っている場合はこれ。
2. テンプレートリポジトリや `create-next-app` 系のスターターから作ると、`.github/dependabot.yml` が最初から含まれていることがある。
3. そもそも `package.json` や `Cargo.toml` のようなマニフェストが無いリポジトリでは何も検出されないため、「入っていない」ように見える。fork もデフォルトでオフ。

確認は各リポジトリの Settings → Code security、および `.github/dependabot.yml` の有無を見る。

## Nix flakes 対応（2026年4月〜）

[GitHub の発表](https://github.blog/changelog/2026-04-07-dependabot-version-updates-now-support-the-nix-ecosystem)により、`package-ecosystem: "nix"` が使えるようになった。`flake.lock` の input を監視し、上流に新しいコミットが出ると input ごとに個別の PR を作る。GitHub / GitLab / Sourcehut / 素の git input に対応。

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "nix"
    directory: "/"
    schedule:
      interval: "weekly"
```

制約が3つあり、dotfiles 用途ではこれが効いてくる。

- **version updates のみ**。セキュリティ更新には対応していない
- **`flake.nix` 内で固定した ref は書き換えない**。更新されるのは `flake.lock` だけ
- **private リポジトリは nix ecosystem 非対応**。dotfiles が private なら動かない

nixpkgs は更新頻度が高いため、weekly でも PR が溜まりやすい。`monthly` に落とすか、後述の update-flake-lock に寄せる。

## なぜ Node.js の CVE 通知が来ないのか

Dependabot alerts は「マニフェストに書かれたパッケージ名とバージョン」を GitHub Advisory Database と突き合わせて発火する。`package.json` に `"express": "4.18.2"` と書いてあるから、express の CVE に反応できる。

`flake.lock` が持っているのは nixpkgs というリポジトリの**コミットハッシュ**だけ。「このロックファイルは Node.js 24.x を含む」という情報はどこにも書かれていない。解決するにはハッシュから nixpkgs を評価してパッケージ一覧を展開する必要があり、Advisory Database の突き合わせ対象になっていない。

したがって Nix 管理のツール類は、**どれだけ CVE が出てもアラートは来ない**。ただし `flake.lock` の nixpkgs を定期的に前へ進めていれば、パッチ済みのパッケージは自然に取り込まれる。通知が来ないだけで、更新自体は回る。

能動的に CVE を拾いたい場合の補完手段は次の2つ。

- **vulnix**: ローカルの Nix store をスキャンし、既知の CVE に該当する derivation を列挙する。CI に組み込める
- **公式のセキュリティ情報を購読**: Node.js の security release 告知など、特に気にする処理系だけ個別に追う

## dotfiles の自動更新

本命は Dependabot ではなく `update-flake-lock` アクション。private リポジトリでも動き、`nix flake update` の結果を PR にしてくれる。

```yaml
# .github/workflows/update-flake.yml
name: update-flake-lock
on:
  schedule:
    - cron: "0 0 * * 1"   # 毎週月曜 00:00 UTC
  workflow_dispatch:       # 手動実行用

jobs:
  update:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
      - uses: DeterminateSystems/nix-installer-action@main
      - uses: DeterminateSystems/update-flake-lock@main
        with:
          pr-title: "chore: update flake.lock"
```

### PR を信用できる状態にする

更新 PR を作るだけでは、壊れた nixpkgs を踏んだときに気づけない。PR に対して検証を走らせる。

- `nix flake check` — flake の評価と check の実行
- `nix build .#homeConfigurations.<name>.activationPackage`（home-manager の場合）または対象の NixOS/darwin 構成をビルド
- これらが通ったら自動マージ、まで寄せるかは好み。nixpkgs unstable を追っている場合、ビルドは通るが実行時に壊れるケースがあるため、**手動マージを残す構成を推奨**

### Dependabot との併用

public リポジトリなら、nix ecosystem を併用すると input ごとに PR が分かれる。「nixpkgs だけ上げたい」「特定の flake だけ止めたい」という操作がしやすい。private なら update-flake-lock 一本でよい。

## Dockerfile の更新自動化

できる。Dependabot には `docker` ecosystem があり、`Dockerfile` の `FROM` 行と `docker-compose.yml` の `image:` を見てベースイメージのタグを更新する。

```yaml
version: 2
updates:
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "npm"      # コンテナ内で使う依存は別途
    directory: "/"
    schedule:
      interval: "weekly"
```

### ただし2層あることに注意

| 層 | 中身 | Dependabot | 対処 |
| --- | --- | --- | --- |
| ベースイメージのタグ | `FROM node:24.3.0` | 更新する | docker ecosystem |
| イメージ内の OS パッケージ | openssl, glibc など | **更新しない** | 定期リビルド + スキャン |
| アプリの依存 | package.json など | 更新する | npm / pip など各 ecosystem |

`FROM node:24` のようにマイナー以下を固定しないタグを使っている場合、Dependabot は「更新すべき差分」を認識しない。リビルドすれば新しい中身になるが、**リビルドしない限り古いまま**。

### 埋め方

- **定期リビルド**: 週次で `docker build --pull --no-cache` を走らせる。これが OS パッケージの更新手段
- **Trivy / Grype でスキャン**: ビルドしたイメージをスキャンし、既知の CVE があれば CI を落とす。Nix 側の vulnix と役割が同じ
- **タグを固定する**: `node:24.3.0-bookworm` のように固定しておくと、Dependabot が差分として検出できて更新が見える化される

## ローカルに何を入れるか

「言語を入れすぎでは」という懸念に対する結論は、**グローバルに入れる数を減らし、プロジェクト単位の devShell に寄せる**こと。Docker に全部逃がす必要はない。

### 判断基準

| 置き場所 | 何を置くか | 理由 |
| --- | --- | --- |
| グローバル（dotfiles の flake） | エディタ、git、シェル、ripgrep など日常ツール | どのプロジェクトでも使う。バージョンが揺れても困らない |
| プロジェクトの devShell | Node.js、JDK、Rust など処理系 | プロジェクトごとにバージョンが違う。`flake.nix` に書けば `direnv` で自動切替 |
| Docker | DB、Redis、メッセージキューなどミドルウェア | ローカルに常駐させたくない。データとポートを隔離したい |

処理系を Docker に入れると、エディタの LSP やフォーマッタがコンテナ外から見えず、開発体験が落ちる。**処理系は Nix の devShell、永続状態を持つミドルウェアは Docker**、という分け方が実務上いちばん摩擦が少ない。

### 管理が分散する問題について

「dockerfile 単位に分散する」という懸念は正しいが、`package.json` を持つのも `flake.nix` を持つのも同じこと。分散自体は避けられないので、**各リポジトリに自動更新の仕組みを入れることをテンプレート化する**方向で解く。

具体的には、自分用のテンプレートリポジトリに `.github/dependabot.yml` と更新ワークフローを入れておき、新規プロジェクトはそこから作る。「入っている／入っていない」が生まれる原因そのものを潰せる。

## 次にやること

- [ ] アカウントの Settings → Code security で、alerts の自動有効化がオンになっているか確認する
- [ ] dotfiles に `update-flake-lock` のワークフローを追加する（週次 + `workflow_dispatch`）
- [ ] 同ワークフローの PR に対して `nix flake check` とビルドを走らせる CI を足す
- [ ] dotfiles が public なら `package-ecosystem: "nix"` も併用する
- [ ] グローバルに入れている処理系を棚卸しし、プロジェクトの devShell へ移す
- [ ] 自分用のテンプレートリポジトリに `.github/dependabot.yml` と更新ワークフローを入れる
- [ ] 気になる処理系（Node.js など）の security release 告知を購読する

## Sources

- [Dependabot version updates now support the Nix ecosystem — GitHub Changelog](https://github.blog/changelog/2026-04-07-dependabot-version-updates-now-support-the-nix-ecosystem)
- [Dependabot Nix Support: What Changed and How to Enable It](https://en.ittrip.xyz/saas/dependabot-nix-support)
- [The Nix moment — Determinate Systems](https://determinate.systems/blog/the-nix-moment/)
