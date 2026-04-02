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
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
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
