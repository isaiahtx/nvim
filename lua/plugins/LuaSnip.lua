return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    { "vhyrro/luarocks.nvim", priority = 1000, config = true },
  },
  rocks = { "jsregexp" },
  opts = {},
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
