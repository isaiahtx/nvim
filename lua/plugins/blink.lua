return {
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
      },
      keymap = {
        ["<Tab>"] = {
          function(cmp)
            if require("luasnip").expandable() then
              vim.schedule(function()
                require("luasnip").expand()
              end)
              return true
            end
          end,
          LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
          "fallback",
        },
      },
    },
  },
}
