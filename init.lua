-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- LuaSnip stuff

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,
  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

-- Check if we are in an SSH session
if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT then
    -- Use lemonade for clipboard
    vim.g.clipboard = {
        name = 'lemonade',
        copy = {
            ['+'] = 'lemonade copy',
            ['*'] = 'lemonade copy',
        },
        paste = {
            ['+'] = 'lemonade paste',
            ['*'] = 'lemonade paste',
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
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

local path = vim.fn.systemlist("luarocks path --lr-path")[1]
package.path = package.path .. ";" .. path
local cpath = vim.fn.systemlist("luarocks path --lr-cpath")[1]
package.cpath = package.cpath .. ";" .. cpath
vim.env.PATH = vim.env.PATH .. ":/Users/isaia/.cargo/bin"
