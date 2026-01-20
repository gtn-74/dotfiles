-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jjマッピング
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- ~/.config/nvim/lua/keybind.lua
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "Reload config" })

-- 検索
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Live Grep" })
