# WezTerm 設定ガイド

## 外観設定

| 設定項目 | 値 | 説明 |
|----------|-----|------|
| `font_size` | 12.0 | フォントサイズ |
| `window_background_opacity` | 0.60 | ウィンドウの透明度 |
| `macos_window_background_blur` | 20 | macOSのぼかし効果 |
| `window_decorations` | RESIZE | タイトルバー非表示、リサイズのみ |
| `use_ime` | true | 日本語入力（IME）有効 |
| `automatically_reload_config` | true | 設定の自動リロード |

タブバーはタブが1つの場合非表示、透過デザイン適用済み。

## キーバインド

### Leader キー

**Leader**: `Ctrl + q`（2秒以内に次のキーを入力）

### Workspace

| キー | 機能 |
|------|------|
| `Leader w` | ワークスペース一覧・切り替え |
| `Leader $` | ワークスペース名を変更 |
| `Leader Shift+W` | 新しいワークスペースを作成 |

### Tab

| キー | 機能 |
|------|------|
| `Cmd t` | 新しいタブ |
| `Cmd w` | タブを閉じる |
| `Ctrl Tab` | 次のタブ |
| `Ctrl Shift Tab` | 前のタブ |
| `Cmd 1`-`9` | タブ番号で移動 |
| `Leader {` | タブを左に移動 |
| `Leader }` | タブを右に移動 |

### Pane

#### 分割・操作

| キー | 機能 |
|------|------|
| `Leader d` | 縦に分割 |
| `Leader r` | 横に分割 |
| `Leader x` | ペインを閉じる |
| `Leader z` | ペインの最大化/復元 |

#### 移動

| キー | 機能 |
|------|------|
| `Leader h/j/k/l` | 左/下/上/右のペインへ移動 |
| `Ctrl Shift [` | ペイン選択モード |

#### リサイズ

1. `Leader s` でリサイズモードに入る
2. `h/j/k/l` でサイズ調整
3. `Enter` でリサイズモード終了

### コピーモード

`Leader [` でコピーモードを開始。Vimライクなキーボード操作でテキスト選択・コピーが可能。

| キー | 機能 |
|------|------|
| `h/j/k/l` | カーソル移動 |
| `w/b/e` | 単語単位の移動 |
| `0/^/$` | 行頭/最初の文字/行末 |
| `g/G` | 先頭/末尾 |
| `Ctrl f/b` | ページ送り/戻し |
| `Ctrl d/u` | 半ページ送り/戻し |
| `v` | 文字選択 |
| `V` | 行選択 |
| `Ctrl v` | 矩形選択 |
| `y` | コピー |
| `Esc/q` | コピーモード終了 |

### その他

| キー | 機能 |
|------|------|
| `Leader >` | WezTerm設定をnvimで開く |
| `Leader <` | Neovim設定をnvimで開く |
| `Cmd c/v` | コピー/ペースト |
| `Cmd p` | コマンドパレット |
| `Ctrl Shift r` | 設定リロード |
| `Alt Enter` | フルスクリーン切り替え |
| `Ctrl +/-/0` | フォントサイズ 拡大/縮小/リセット |

## 参考リンク

- [WezTerm 公式ドキュメント](https://wezfurlong.org/wezterm/)
