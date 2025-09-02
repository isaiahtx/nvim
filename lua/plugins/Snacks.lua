-- ~/.config/nvim/lua/plugins/Snacks.lua
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- detect WSL / Linux under Microsoft kernel
    local is_wsl = (vim.env.WSL_DISTRO_NAME ~= nil)
      or (vim.fn.has("wsl") == 1)
      or (vim.fn.system("uname -r"):lower():find("microsoft") ~= nil)

    opts = opts or {}
    opts.image = opts.image or {}
    opts.image.enabled = not is_wsl -- disable in WSL

    -- enable/disable other modules here if you like
    -- opts.explorer = { enabled = true }
    -- opts.scroll   = { enabled = true }

    return opts
  end,
}
