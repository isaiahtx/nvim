vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootsrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Ensure clipboard yank maps exist even if VeryLazy is delayed (e.g. vscode-neovim)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Yank to end of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

-- Clipboard setup
local function is_wsl()
  if vim.fn.has("wsl") == 1 then
    return true
  end
  local ok, version = pcall(vim.fn.readfile, "/proc/version")
  if ok and version[1] and version[1]:lower():find("microsoft", 1, true) then
    return true
  end
  return false
end

local ssh = vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT

if ssh and vim.fn.executable("lemonade") == 1 then
  -- Use lemonade for clipboard
  vim.g.clipboard = {
    name = "lemonade",
    copy = {
      ["+"] = "lemonade copy",
      ["*"] = "lemonade copy",
    },
    paste = {
      ["+"] = "lemonade paste",
      ["*"] = "lemonade paste",
    },
    cache_enabled = 0,
  }
elseif ssh then
  -- No lemonade (e.g. a Coder workspace): copy through the terminal with OSC 52.
  -- Many terminals ignore OSC 52 reads, so "+p pastes the last thing Neovim
  -- copied; paste from the system clipboard with the terminal's paste key.
  local osc52 = require("vim.ui.clipboard.osc52")
  local last = { {}, "v" }
  local function copy(reg)
    local send = osc52.copy(reg)
    return function(lines, regtype)
      last = { lines, regtype }
      send(lines, regtype)
    end
  end
  local function paste()
    return last
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
elseif is_wsl() and vim.fn.executable("win32yank.exe") == 1 then
  -- win32yank handles UTF-8 correctly in both directions.
  -- Install: ~/.local/bin/win32yank.exe (from github.com/equalsraf/win32yank).
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = { "win32yank.exe", "-i", "--crlf" },
      ["*"] = { "win32yank.exe", "-i", "--crlf" },
    },
    paste = {
      ["+"] = { "win32yank.exe", "-o", "--lf" },
      ["*"] = { "win32yank.exe", "-o", "--lf" },
    },
    cache_enabled = 0,
  }
end

local path = vim.fn.systemlist("luarocks path --lr-path")[1]
package.path = package.path .. ";" .. path
local cpath = vim.fn.systemlist("luarocks path --lr-cpath")[1]
package.cpath = package.cpath .. ";" .. cpath

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("silent! wa") -- write all
    vim.cmd("silent! qall!") -- quit all
  end,
})
