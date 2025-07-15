return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      ---------------------------------------------------------------------------
      -- helpers ----------------------------------------------------------------
      ---------------------------------------------------------------------------
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      local function jump(dir, fallback)
        if luasnip.expand_or_jumpable() then
          if dir == 1 and luasnip.expandable() then
            luasnip.expand()
          else
            luasnip.jump(dir)
          end
        else
          fallback()
        end
      end

      ---------------------------------------------------------------------------
      -- key‑mappings -----------------------------------------------------------
      ---------------------------------------------------------------------------
      opts.mapping =
        cmp.mapping.preset.insert(vim.tbl_extend("force", opts.mapping or {}, {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif has_words_before() then
              cmp.complete()
            else
              jump(1, fallback)
            end
          end, { "i", "s" }),

          -- Jump / expand
          ["<C-j>"] = cmp.mapping(function(fallback)
            jump(1, fallback)
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            jump(-1, fallback)
          end, { "i", "s" }),

          -- macOS Cmd aliases (terminal must forward <D-j>/<D-k>)
          ["<D-j>"] = cmp.mapping(function(fallback)
            jump(1, fallback)
          end, { "i", "s" }),
          ["<D-k>"] = cmp.mapping(function(fallback)
            jump(-1, fallback)
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }))

      ---------------------------------------------------------------------------
      -- completion sources -----------------------------------------------------
      ---------------------------------------------------------------------------
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
        { name = "copilot" },
      })
    end,
  },
}
