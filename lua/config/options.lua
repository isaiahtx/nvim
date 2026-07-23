vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")
vim.opt.wrap = true
vim.opt.clipboard = ""

-- Ensure tools are visible to Neovim when launched from Cursor/VSCode
do
  local home = vim.env.HOME
  local extras = {
    home .. "/.local/bin",
    home .. "/.local/share/nvim/mason/bin",
    home .. "/.npm-global/bin",
    home .. "/.cargo/bin",
    "/usr/local/bin",
  }
  local path = vim.env.PATH or ""
  for _, dir in ipairs(extras) do
    if not path:find(dir, 1, true) then
      path = dir .. ":" .. path
    end
  end
  vim.env.PATH = path
end

-- Optional providers we don't use
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

