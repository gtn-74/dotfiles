return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      emmet_language_server = {
        filetypes = {
          "html", "css", "scss", "less",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue", "svelte",
          "markdown", "mdx",
          "rust", "go", "python", "lua",
        },
      },
    },
  },
}
