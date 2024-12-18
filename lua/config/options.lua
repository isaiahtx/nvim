-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- So yanking/deleting does not cause text to enter my system clipboard
vim.opt.clipboard = ""

vim.opt.colorcolumn = "80"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.fo = "jntrocqp"
vim.g.lazyvim_cmp = "nvim-cmp"
