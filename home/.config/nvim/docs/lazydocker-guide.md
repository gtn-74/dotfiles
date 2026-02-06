# lazydocker 使い方ガイド

## アーキテクチャ

各ツールはレイヤーが異なる。Docker Desktop も colima もエンジン層の役割は同じ。

```
┌─────────────────────────────┐
│  lazydocker (管理 TUI)      │  ← 見る・操作する
├─────────────────────────────┤
│  docker compose up (コンテナ)│  ← コンテナを作る・起動する
├─────────────────────────────┤
│  colima (デーモン)           │  ← エンジンを動かす
└─────────────────────────────┘
```

- **colima / Docker Desktop** はエンジン。これがないとコンテナは動かない。
- **docker compose up** はコンテナの起動。エンジンが何であっても毎回必要。
- **lazydocker** は管理画面。起動中のコンテナを確認・操作する。

以前 Docker Desktop で `docker compose up` だけで動いていたのは、
Docker Desktop がバックグラウンドで常にエンジンを起動していたため。
colima に変えたことで、エンジン起動を自分で明示的にやるようになっただけ。

### OS ごとのデーモン

| OS | デーモン | 起動コマンド |
|----|---------|-------------|
| macOS | colima | `colima start` |
| Ubuntu | docker-ce (systemd) | `sudo systemctl start docker` |
| Windows | WSL2 + docker-ce | `sudo service docker start` |

## 前提条件

- Docker CLI (`brew install docker`)
- colima (`brew install colima`) — macOS 用の軽量 Docker デーモン
- lazydocker (`brew install lazydocker`)

## colima (Docker デーモン) の操作

lazydocker を使うには、先に Docker デーモンを起動する必要がある。

```bash
colima start          # デーモン起動
colima stop           # デーモン停止
colima status         # 状態確認
colima start --cpu 4 --memory 8  # リソース指定して起動
```

### ログイン時に自動起動する場合

```bash
brew services start colima    # 自動起動を有効化
brew services stop colima     # 自動起動を無効化
```

## lazydocker の起動

### ターミナルから

```bash
lazydocker
```

### nvim から

| キー | 動作 |
|------|------|
| `<leader>gD` | lazydocker を開く |

snacks.nvim の terminal 機能で起動する。終了すると nvim に戻る。

## 画面構成

```
┌──────────────┬─────────────────────────┐
│  Containers  │                         │
│  ─────────── │      Logs / Stats /     │
│  Images      │      Config / Top       │
│  ─────────── │                         │
│  Volumes     │      (詳細パネル)       │
│  ─────────── │                         │
│  Networks    │                         │
└──────────────┴─────────────────────────┘
   左パネル          右パネル
```

## 基本キーバインド

### ナビゲーション

| キー | 動作 |
|------|------|
| `j` / `k` | 上下移動 |
| `h` / `l` | パネル切り替え |
| `[` / `]` | 詳細パネルのタブ切り替え (Logs, Stats, Config) |
| `Enter` | 詳細表示 |
| `q` | 終了 |

### コンテナ操作

| キー | 動作 |
|------|------|
| `d` | コンテナ削除/停止 |
| `s` | コンテナ停止 |
| `r` | コンテナ再起動 |
| `a` | コンテナにアタッチ |
| `e` | コンテナ内でシェル起動 |
| `x` | メニューを開く (各種操作) |
| `b` | バルクコマンド (一括操作) |

## 基本的なワークフロー

1. `colima start` で Docker デーモンを起動
2. `<leader>gD` (nvim) または `lazydocker` (ターミナル) で起動
3. `h` / `l` で左パネルのセクションを切り替え
4. `j` / `k` でコンテナ/イメージを選択
5. `]` / `[` で Logs / Stats / Config タブを切り替えて確認
6. `e` でコンテナ内のシェルに接続
7. `q` で終了
8. 作業が終わったら `colima stop` でデーモン停止

## docker-compose 連携

`docker-compose.yml` があるディレクトリで起動すると、Services パネルが追加表示され、compose 単位で管理できる。

## データの永続化と注意点

### データは残るか？

データの永続化はエンジン（colima / Docker Desktop）ではなく、
`docker-compose.yml` の `volumes` 設定で決まる。

```yaml
# ホストマウントの例（Musica001）
volumes:
  - ./docker/postgres/pgdata:/var/lib/postgresql/data
```

- `colima stop` → `colima start` → `docker compose up -d` してもデータは残る
- ホスト側のディレクトリにファイルが保存されているため

### Docker Desktop → colima 移行時の注意

- Docker Desktop と colima は**別のエンジン**なので、Docker Desktop 時代に作った Docker 管理ボリューム（名前付きボリューム）は colima に引き継がれない
- ホストディレクトリにマウントしている場合はファイルがホスト側にあるため影響なし

## 設定ファイル

カスタム設定は以下に配置 (初回起動時に自動生成):

```
~/.config/lazydocker/config.yml
```
