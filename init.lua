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

vim.g.vimtex_view_method = "zathura"
