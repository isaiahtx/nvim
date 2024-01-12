vim.g.vimtex_indent_lists = {}
return {
  {
    "lervag/vimtex",
    config = function()
      vim.g["tex_flavor"] = "latex"
      vim.g["vimtex_view_method"] = "skim"
      vim.g["vimtex_quickfix_mode"] = 0
      vim.g["vimtex_syntax_conceal_disable"] = 0
      vim.g["vimtex_syntax_conceal"] = {
        accents = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 0,
        math_delimiters = 0,
        math_fracs = 0,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 1,
      }
      vim.g["vimtex_compiler_latexmk"] = {
        aux_dir = "build",
        out_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        hooks = {},
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.o.conceallevel = 2
      vim.keymap.set("n", "<leader>v", function()
        vim.cmd(":VimtexView")
      end, { desc = "Vimtex [V]iew" })
    end,
  },
}
