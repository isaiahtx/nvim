return {
  "L3MON4D3/LuaSnip",
  -- jsregexp is a user rock (`luarocks --local install jsregexp`; the Coder
  -- dotfiles install it), found through the `luarocks path` lines in init.lua.
  -- Ensure snippets/config load at startup (keys alone would make this lazy).
  lazy = false,
  priority = 1000,
  opts = {
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.config.set_config(opts)
    require("luasnip.loaders.from_lua").load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
  end,
  keys = {
    {
      "<C-j>",
      function()
        if require("luasnip").locally_jumpable(1) then
          require("luasnip").jump(1)
        end
      end,
      mode = { "i", "s" },
      desc = "LuaSnip jump forward",
    },
    {
      "<NL>",
      function()
        if require("luasnip").locally_jumpable(1) then
          require("luasnip").jump(1)
        end
      end,
      mode = { "i", "s" },
      desc = "LuaSnip jump forward",
    },
    {
      "<C-k>",
      function()
        if require("luasnip").locally_jumpable(-1) then
          require("luasnip").jump(-1)
        end
      end,
      mode = { "i", "s" },
      desc = "LuaSnip jump backward",
    },
  },
}
