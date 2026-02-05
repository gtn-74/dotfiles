# nvim-dbee 使い方ガイド

## 起動・終了

```vim
:Dbee        " UIを開く（トグル）
```

Luaから:
```lua
require("dbee").open()   -- 開く
require("dbee").close()  -- 閉じる
require("dbee").toggle() -- トグル
```

## ウィンドウ構成

```
┌─────────────┬────────────────────────┐
│  ドロワー   │      エディター        │
│  (左上)     │      (右上)            │
│  接続一覧   │   クエリを書く場所     │
│  スクラッチ │                        │
├─────────────┴────────────────────────┤
│            結果ウィンドウ            │
│           (クエリ結果表示)           │
└──────────────────────────────────────┘
```

## ウィンドウ間の移動

通常のVimウィンドウ移動を使用:

| キー | 動作 |
|------|------|
| `<C-w>h` | 左のウィンドウへ |
| `<C-w>j` | 下のウィンドウへ |
| `<C-w>k` | 上のウィンドウへ |
| `<C-w>l` | 右のウィンドウへ |
| `<C-w>w` | 次のウィンドウへ (順番に移動) |

## ドロワー (サイドバー) の操作

| キー | 動作 |
|------|------|
| `o` | ノードを展開/折りたたみ |
| `<CR>` (Enter) | アクション実行 (接続選択、テーブル内容表示など) |
| `r` | ツリーをリフレッシュ |
| `cw` | 接続/スクラッチパッドを編集 |
| `dd` | 接続/スクラッチパッドを削除 |

### 接続の追加

1. ドロワーの「add」を選択して `<CR>`
2. 接続情報を入力
3. `:w` で保存

## エディター (クエリ作成) の操作

| キー | モード | 動作 |
|------|--------|------|
| `BB` | ノーマル | ファイル全体をクエリとして実行 |
| `BB` | ビジュアル | 選択範囲をクエリとして実行 |
| `<CR>` | ノーマル | カーソル行を実行 |

## 結果ウィンドウの操作

| キー | 動作 |
|------|------|
| `L` | 次のページ |
| `H` | 前のページ |
| `E` | 最後のページ |
| `F` | 最初のページ |
| `yaj` | 現在行をJSONでヤンク |
| `yac` | 現在行をCSVでヤンク |
| `yaJ` | 全行をJSONでヤンク |
| `yaC` | 全行をCSVでヤンク |

## 接続設定例

### 設定ファイルで指定

`~/.config/nvim/lua/plugins/dbee.lua`:

```lua
return {
  "kndndrj/nvim-dbee",
  dependencies = { "MunifTanjim/nui.nvim" },
  build = function()
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup({
      sources = {
        require("dbee.sources").MemorySource:new({
          {
            name = "My SQLite DB",
            type = "sqlite",
            url = "~/path/to/database.db",
          },
          {
            name = "My PostgreSQL",
            type = "postgres",
            url = "postgres://user:pass@localhost:5432/dbname",
          },
        }),
      },
    })
  end,
}
```

### 環境変数で指定 (秘密情報を隠す)

接続URLにプレースホルダーを使用:

```lua
{
  name = "Production DB",
  type = "postgres",
  url = "postgres://{{ env 'DB_USER' }}:{{ env 'DB_PASS' }}@localhost:5432/mydb",
}
```

### 対応データベース

- `sqlite`
- `postgres`
- `mysql`
- `duckdb`
- `bigquery`
- `oracle`
- `sqlserver`
- `clickhouse`
- `mongo`
- `redis`

## 基本的なワークフロー

1. `:Dbee` でUIを開く
2. `<C-w>h` でドロワー（左サイドバー）に移動
3. 接続を選択して `<CR>` でアクティブ化
4. テーブルを展開して構造を確認
5. `<C-w>l` でエディターに移動
6. SQLクエリを記述
7. `BB` でクエリ実行
8. `<C-w>j` で結果ウィンドウに移動して確認
