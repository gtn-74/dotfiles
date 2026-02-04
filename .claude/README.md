# Claude Code ショートカット

## 入力編集

| キー | 機能 |
|------|------|
| `Ctrl+U` | 入力テキストを全削除 |
| `Ctrl+K` | カーソルから行末まで削除 |
| `Ctrl+Y` | 削除したテキストを貼り付け |
| `Alt+Y` | 貼り付け履歴を巡回（`Ctrl+Y`の後） |
| `Alt+B` | 1単語戻る |
| `Alt+F` | 1単語進む |

## マルチライン入力

| キー | 機能 |
|------|------|
| `\` + `Enter` | 改行（全ターミナル共通） |
| `Shift+Enter` | 改行（iTerm2, WezTerm, Ghostty, Kitty） |
| `Option+Enter` | 改行（macOSデフォルト） |
| `Ctrl+J` | 改行（ラインフィード） |

## 操作

| キー | 機能 |
|------|------|
| `Enter` | 送信 |
| `Ctrl+C` | 入力キャンセル / 生成中断 |
| `Ctrl+D` | セッション終了 |
| `Ctrl+L` | 画面クリア（会話履歴は保持） |
| `Ctrl+R` | コマンド履歴の検索 |
| `Ctrl+G` | 外部エディタでプロンプト編集 |
| `Ctrl+O` | 詳細出力の切り替え |
| `Esc Esc` | 会話を前の状態に巻き戻し |

## モード切替

| キー | 機能 |
|------|------|
| `Shift+Tab` / `Alt+M` | 権限モード切替（Auto-Accept / Plan / Normal） |
| `Option+P` | モデル切替 |
| `Option+T` | 拡張思考モードの切替 |

## 入力補助

| 記号 | 機能 |
|------|------|
| `/` | スラッシュコマンド（`/clear`, `/compact`, `/cost` 等） |
| `!` | Bashコマンドを直接実行 |
| `@` | ファイルパス補完 |

## よく使うスラッシュコマンド

| コマンド | 機能 |
|----------|------|
| `/clear` | 会話履歴をクリア |
| `/compact` | 会話をコンパクト化 |
| `/cost` | トークン使用量を表示 |
| `/model` | AIモデルを変更 |
| `/memory` | CLAUDE.mdを編集 |
| `/vim` | Vimモード有効化 |
| `/theme` | カラーテーマ変更 |

## macOSでのAlt/Optionキー設定

Alt系ショートカットを使うにはターミナル側の設定が必要:

- **WezTerm**: デフォルトで対応済み
- **iTerm2**: Settings > Profiles > Keys > Left Option を "Esc+" に変更
- **Terminal.app**: Settings > Profiles > Keyboard > "Use Option as Meta Key" を有効化
