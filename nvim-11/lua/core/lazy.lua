-- Bootstrap and configure lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    -- Import plugin specs from the plugins directory
    { import = "plugins" },
  },
  defaults = {
    lazy = true,      -- load plugins lazily
    version = false,  -- always use the latest git commit
  },
  install = { colorscheme = { "rose-pine" } },
  checker = { enabled = true, notify = false },  -- automatically check for plugin updates
  debug = true, -- enable debug logging
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})
