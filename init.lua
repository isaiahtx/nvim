-- bootsrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- LuaSnip stuff

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("luasnip").config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

-- Check if we are in an SSH session
if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT then
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
elseif vim.fn.has("wsl") == 1 then
  -- win32yank handles UTF-8 correctly in both directions. clip.exe decodes
  -- piped bytes via the legacy OEM codepage (CP437), turning em dashes/emoji
  -- into mojibake (ΓÇö, Γ£à); the old PowerShell paste likewise downgraded
  -- non-ASCII to "-"/"?". --crlf/--lf convert line endings natively, which
  -- also replaces the previous Get-Clipboard \r-stripping workaround.
  -- Install: ~/.local/bin/win32yank.exe (from github.com/equalsraf/win32yank).
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

local path = vim.fn.systemlist("luarocks path --lr-path")[1]
package.path = package.path .. ";" .. path
local cpath = vim.fn.systemlist("luarocks path --lr-cpath")[1]
package.cpath = package.cpath .. ";" .. cpath
vim.env.PATH = vim.env.PATH .. ":/Users/isaia/.cargo/bin"

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("silent! wa") -- write all
    vim.cmd("silent! qall!") -- quit all
  end,
})
