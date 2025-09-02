-- ~/.config/nvim/lua/plugins/vimtex.lua  (or $NDOTDIR/... in your setup)
return {
  {
    "lervag/vimtex",
    init = function() -- use init so VimTeX reads these before it loads
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.g.vimtex_subfile_start_local = 1

      if vim.fn.has("mac") == 1 then
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_compiler_progname = "nvr"
        vim.g.vimtex_view_general_options = "-r @line @pdf @src"
      else
        vim.g.vimtex_view_method = "zathura"
        -- ⬇️ THIS is the key line: tell Zathura to call nvr back into THIS Neovim
        vim.g.vimtex_view_zathura_options =
          [[-x "nvr --servername $NVIM --remote-silent +%{line} %{input}"]]
      end

      vim.g.vimtex_compiler_latexmk = {
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
          "-use-make",
        },
      }

      vim.o.conceallevel = 2
      vim.keymap.set(
        "n",
        "<leader>v",
        "<cmd>VimtexView<cr>",
        { desc = "VimTeX view" }
      )
      vim.g.vimtex_subfile_start = 1
    end,
  },
}
