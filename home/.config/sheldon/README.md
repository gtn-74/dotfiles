# Sheldon 設定ガイド

Sheldon は Rust 製の高速なシェルプラグインマネージャーです。

## 目次

- [概要](#概要)
- [インストール済みプラグイン](#インストール済みプラグイン)
- [基本コマンド](#基本コマンド)
- [プラグインの追加方法](#プラグインの追加方法)
- [トラブルシューティング](#トラブルシューティング)

---

## 概要

### oh-my-zsh との違い

| 項目 | oh-my-zsh | Sheldon |
|------|-----------|---------|
| 起動速度 | 遅め | 高速 |
| 設定形式 | シェルスクリプト | TOML |
| プラグイン管理 | 一体型 | 個別管理 |
| カスタマイズ性 | フレームワーク依存 | 自由 |

### ファイル構成

| ファイル | 場所 | 説明 |
|----------|------|------|
| `plugins.toml` | `~/.config/sheldon/` | プラグイン設定（編集対象） |
| `plugins.lock` | `~/.local/share/sheldon/` | バージョン固定ファイル（自動生成） |
| キャッシュ | `~/.local/share/sheldon/repos/` | ダウンロードしたプラグイン |

---

## インストール済みプラグイン

| プラグイン | 説明 |
|------------|------|
| oh-my-zsh (lib) | zsh の基本ライブラリ |
| jonathan theme | プロンプトテーマ |
| ohmyzsh-git | git エイリアス・補完 |
| zsh-completions | 追加の補完定義 |
| zsh-autosuggestions | 履歴ベースのコマンド候補表示 |
| zsh-syntax-highlighting | コマンドのシンタックスハイライト |
| fzf | ファジーファインダー |
| zoxide | スマートな cd コマンド |

---

## 基本コマンド

### プラグインのダウンロード・更新

```bash
# プラグインをダウンロード（plugins.toml 変更後に実行）
sheldon lock

# すべてのプラグインを最新版に更新
sheldon lock --update
```

### 設定ファイルの編集

```bash
# エディタで plugins.toml を開く
sheldon edit

# プラグイン一覧を表示
sheldon list
```

### その他

```bash
# sheldon のバージョン確認
sheldon --version

# ヘルプ表示
sheldon --help
```

---

## プラグインの追加方法

### 1. plugins.toml を編集

```toml
# GitHub リポジトリから追加
[plugins.example-plugin]
github = "author/repository"

# 特定のファイルのみ使用
[plugins.example-plugin]
github = "author/repository"
use = ["*.zsh"]

# インラインで記述
[plugins.my-config]
inline = 'export MY_VAR="value"'
```

### 2. プラグインをダウンロード

```bash
sheldon lock
```

### 3. 新しいターミナルを開く

または `source ~/.config/zsh/.zshrc` を実行。

---

## トラブルシューティング

### `compdef: command not found` エラー

**原因**: 補完システム（compinit）が初期化される前にプラグインが読み込まれている

**解決**: plugins.toml の先頭に compinit を追加

```toml
[plugins.compinit]
inline = 'autoload -Uz compinit && compinit'
```

### プラグインが反映されない

```bash
# ロックファイルを再生成
sheldon lock

# キャッシュをクリアして再ダウンロード
rm -rf ~/.local/share/sheldon
sheldon lock
```

### 起動が遅い場合

```bash
# 起動時間を計測
time zsh -i -c exit

# どのプラグインが遅いか確認
sheldon source --profile
```

---

## 参考リンク

- [Sheldon 公式ドキュメント](https://sheldon.cli.rs/)
- [Sheldon GitHub](https://github.com/rossmacarthur/sheldon)

---

**作成日**: 2026-01-29
