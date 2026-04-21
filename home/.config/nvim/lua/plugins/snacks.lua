return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      -- WezTerm はプレースホルダー非対応のためフォールバックレンダリングを使用
      doc = {
        enabled = true,  -- markdown内のインライン画像を有効化
        inline = false,  -- WezTermではfalseにする（placeholderエラー回避）
      },
    },
  },
}
