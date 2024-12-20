vim.g.vimtex_indent_lists = {}
return {
  {
    "lervag/vimtex",
    config = function()
      vim.g["tex_flavor"] = "latex"
      vim.g["vimtex_quickfix_mode"] = 0
      vim.g["vimtex_syntax_conceal_disable"] = 0
      vim.g["vimtex_subfile_start_local"] = 1

      if vim.fn.system("uname") == "Darwin\n" then
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_compiler_progname = "nvr"
        vim.g["vimtex_view_general_options"] = "-r @line @pdf @src"
      else
        vim.g.vimtex_view_method = "zathura"
        vim.g["vimtex_view_general_options"] = "-reuse-instance @pdf"
      end

      vim.g["vimtex_syntax_conceal"] = {
        accents = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
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
          "-pdf",
          "-interaction=nonstopmode",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-bibtex",
          "-use-make", -- Use `biber` instead of `bibtex`
        },
      }
      --    vim.g["vimtex_compiler_latexmk"] = {
      --      aux_dir = "build",
      --      out_dir = "build",
      --      callback = 1,
      --      continuous = 1,
      --      executable = "latexmk",
      --      hooks = {},
      --      options = {
      --        "-pdf",
      --        "-interaction=nonstopmode",
      --        "-shell-escape",
      --        "-verbose",
      --        "-file-line-error",
      --        "-synctex=1",
      --      },
      --    }
      vim.o.conceallevel = 2
      vim.keymap.set("n", "<leader>v", function()
        vim.cmd(":VimtexView")
      end, { desc = "Vimtex [V]iew" })
      vim.g.vimtex_subfile_start = 1
    end,
  },
}
