# デバッグ（nvim-dap / DAP）

LazyVim で TypeScript（Node.js）をブレークポイントを貼ってデバッグするための前提とキーマップ。

## 前提: 拡張の有効化（最初の1回だけ）

`:LazyExtras` を開いて以下に `x` で有効化:

- **`dap.core`** → デバッガ本体(`nvim-dap` + UI)

有効化後に nvim を再起動。Mason が `js-debug-adapter` を自動インストールする。進捗は `:Mason`。

> 直接書き換える場合は `~/.config/nvim/lazyvim.json` の `"extras": []` に
> `"lazyvim.plugins.extras.dap.core"` を足す。

LazyVim はプロジェクト直下の `.vscode/launch.json` を自動で読み込む。

## キーマップ（`<leader>d` 系）

| キー | 動作 |
|------|------|
| `<leader>db` | ブレークポイントを置く/外す（今の行） |
| `<leader>dB` | 条件付きブレークポイント（例 `quantity > 3`） |
| `<leader>dc` | デバッグ開始 / 続行（launch.json の構成を選ぶ） |
| `<leader>dO` | ステップオーバー（次の行へ） |
| `<leader>di` | ステップイン（関数の中へ） |
| `<leader>do` | ステップアウト |
| `<leader>du` | デバッグ UI（変数・コールスタック）開閉 |
| `<leader>de` | カーソル下の式を評価 |
| `<leader>dt` | デバッグ終了 |

## 実践: サーバにブレークポイントを貼り、リクエストで止める

1. 対象ファイルの止めたい行で **`<leader>db`**（赤い ● が付く）
2. 別ターミナルでサーバを `--inspect` 付きで起動:
   ```bash
   npm run start:debug      # node --inspect で 9229 を開く
   ```
3. nvim で **`<leader>dc` → `Attach (server :9229)`** を選ぶ
4. さらに別ターミナルからリクエストを投げる:
   ```bash
   curl -X POST http://localhost:3000/products/1/purchase \
     -H 'Content-Type: application/json' -d '{"quantity":5}'
   ```
5. ブレークポイントで停止。`<leader>du` で変数パネルを開き、`<leader>dO` で 1 行ずつ追う。`<leader>de` で式評価も。

> `launch.json` で `restart: true` にしておくと、サーバ再起動時に自動で attach し直す。

## もう一つの手: テストにブレークポイントを貼る

テストや service 側に `<leader>db` を置き、**`<leader>dc` → `Debug e2e tests (jest)`** を選ぶと、テスト経由でロジックをステップ実行できる（`--inspect-brk` で最初から 1 ステップずつ）。

## つまずきやすい点

- **`<leader>d` が無い** → extras 未反映。`:LazyExtras` で `dap.core` を有効化＆再起動できているか、`:Mason` で `js-debug-adapter` が ✓ か確認。
- **ブレークポイントで止まらない** → `npm run start:debug`（`--inspect` 版）で起動しているか。通常の `npm start` だと 9229 が開かない。
- **行がズレて止まる** → ソースマップ。`tsconfig.json` に `"sourceMap": true` が必要。
