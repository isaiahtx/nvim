-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("v", "<leader>y", '"+y')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')
map("n", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
vim.keymap.del("n", "<leader>l")
map("n", "<leader>ll", ":VimtexCompile<CR>")
map("n", "<leader>lv", ":VimtexView<CR>")
-- map("i", "<Left>", "")
-- map("i", "<Right>", "")
-- map("i", "<Up>", "")
-- map("i", "<Down>", "")
map("v", "<Left>", "")
map("v", "<Right>", "")
map("v", "<Up>", "1<Up>")
map("v", "<Down>", "1<Down>")
map("n", "<Left>", "")
map("n", "<Right>", "")
map("n", "<Up>", "1<Up>")
map("n", "<Down>", "1<Down>")
