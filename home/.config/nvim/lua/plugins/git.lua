return {
  -- gitsigns.nvim: GitLens風のblame表示 + gutter signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
  },

  -- diffview.nvim: diff/ログビューア
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "File History (all)" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    opts = {},
  },
}
