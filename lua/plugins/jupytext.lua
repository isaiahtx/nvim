return {
  {
    "GCBallesteros/jupytext.nvim",
    config = function(_, opts)
      -- Databricks notebooks lack kernelspec/language_info metadata, which
      -- crashes the plugin's metadata reader. Patch it to fall back to
      -- python (the only kernel in use here).
      local utils = require "jupytext.utils"
      local get_ipynb_metadata = utils.get_ipynb_metadata
      utils.get_ipynb_metadata = function(filename)
        local ok, metadata = pcall(get_ipynb_metadata, filename)
        if ok and metadata.language then
          return metadata
        end
        return { language = "python", extension = "py" }
      end
      require("jupytext").setup(opts)
    end,
    opts = {
      -- "auto" would pass --to=auto:hydrogen to jupytext, which fails on
      -- notebooks without language metadata; pin to py.
      output_extension = "py",
    },
  },
}
