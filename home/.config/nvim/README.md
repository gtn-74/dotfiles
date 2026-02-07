# Neovim 設定ガイド

[LazyVim](https://lazyvim.github.io/) ベースの Neovim 設定。

## 構成

```
lua/
├── config/
│   ├── lazy.lua       # lazy.nvim セットアップ
│   ├── keymaps.lua    # カスタムキーマップ
│   ├── options.lua    # オプション設定
│   └── autocmds.lua   # 自動コマンド
└── plugins/
    ├── neo-tree.lua    # ファイルツリー設定
    └── git.lua         # Git関連プラグイン設定
```

## カスタムキーマップ

| キー | モード | 機能 |
|------|--------|------|
| `jj` | Insert | Escでノーマルモードへ |
| `<leader>r` | Normal | 設定ファイルのリロード |
| `<leader>/` | Normal | Live Grep（FzfLua） |

## プラグイン設定

### Neo-tree（ファイルツリー）

`<leader>e` でサイドバーの表示/非表示を切り替え（幅: 25）。

| キー | 機能 |
|------|------|
| `Enter` | ファイルを開く / ディレクトリを展開 |
| `a` | 新規ファイル・ディレクトリ作成 |
| `d` | 削除 |
| `r` | 名前変更 |
| `x` | カット |
| `c` | コピー |
| `p` | ペースト |
| `H` | 隠しファイル表示切り替え |
| `R` | ツリーをリフレッシュ |
| `?` | ヘルプ表示 |

### Git: gitsigns.nvim

カーソル行にblame情報（著者、日付、コミットメッセージ）をインライン表示する。

LazyVimデフォルトのキーマップ:

| キー | 機能 |
|------|------|
| `]h` | 次のhunkへ移動 |
| `[h` | 前のhunkへ移動 |
| `<leader>ghs` | hunkをステージ |
| `<leader>ghr` | hunkをリセット |
| `<leader>ghS` | バッファ全体をステージ |
| `<leader>ghR` | バッファ全体をリセット |
| `<leader>ghp` | hunkをプレビュー |
| `<leader>ghb` | blame（行単位） |
| `<leader>ghd` | diff表示 |

### Git: diffview.nvim

Git差分やファイル履歴をタブで表示するビューア。

| キー | 機能 |
|------|------|
| `<leader>gd` | Diffビューを開く |
| `<leader>gf` | 現在のファイルのGit履歴 |
| `<leader>gF` | リポジトリ全体のGit履歴 |
| `<leader>gq` | Diffビューを閉じる |

### Git: Lazygit

snacks.nvim 経由で統合されたGit TUI。

| キー | 機能 |
|------|------|
| `<leader>gg` | Lazygitを開く |

Lazygit内の操作:

| キー | 機能 |
|------|------|
| `1`-`5` | パネル切り替え |
| `Enter` | diff表示 |
| `スペース` | ステージ/アンステージ |
| `c` | コミット |
| `P` | プッシュ |
| `p` | プル |
| `?` | ヘルプ |
| `q` | 終了 |

## バッファ操作

| キー | 機能 |
|------|------|
| `<leader>bd` | バッファを閉じる |
| `<leader>bo` | 他の全バッファを閉じる |
| `<leader>bb` | バッファ一覧から選択 |
| `<leader>,` | 最近のバッファに切り替え |

## ファイルナビゲーション（組み込み）

| キー | 機能 |
|------|------|
| `gf` | カーソル下のファイルパスをNeovm内で開く |
| `<C-w>f` | 新しいウィンドウ分割で開く |
| `<C-w>gf` | 新しいタブで開く |
| `gx` | カーソル下のURLをブラウザで開く |

## ウィンドウ操作

| キー | 機能 |
|------|------|
| `Ctrl-w h/j/k/l` | ウィンドウ移動（左/下/上/右） |
| `Ctrl-w w` | 次のウィンドウへ順番に移動 |
| `Ctrl-w q` | ウィンドウを閉じる |
| `Ctrl-w =` | ウィンドウサイズを均等に |
| `:sp` | 水平分割 |
| `:vsp` | 垂直分割 |

## Git 基本操作（コマンドライン）

### .gitignore

ファイルやディレクトリをGitの追跡対象から除外する。

```gitignore
# ディレクトリ内を全て除外し、特定ファイルだけ追跡する例
.claude/*
!.claude/README.md
!.claude/settings.local.json
```

- `*` で全ファイルを除外し、`!` で個別に追跡対象へ戻す
- `!`（否定パターン）がないと再追加にならないので注意

### よく使うコマンド

| コマンド | 機能 |
|----------|------|
| `git add <file>` | ファイルをステージング |
| `git reset <file>` | ステージングを取り消し |
| `git diff` | ステージング前の差分を表示 |
| `git diff --staged` | ステージング済みの差分を表示 |
| `git log --oneline` | コミット履歴を1行表示 |
| `git stash` | 変更を一時退避 |
| `git stash pop` | 退避した変更を復元 |
| `git checkout -b <branch>` | 新しいブランチを作成して切替 |

## 参考リンク

- [LazyVim ドキュメント](https://lazyvim.github.io/)
- [LazyVim デフォルトキーマップ](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
- [Neovim 公式サイト](https://neovim.io/)
