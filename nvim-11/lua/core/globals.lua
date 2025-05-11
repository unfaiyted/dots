-- Define global variables that are used throughout Neovim config

-- This is a special comment that tells lua-language-server not to complain about vim
---@diagnostic disable: undefined-global
_G.globals = {}

-- Add a handy function that can be used in any lua file to declare vim as local
globals.use_vim = function()
  -- This is never actually called at runtime, it's just to make the linter happy
  -- when we do `local vim = vim` at the top of each file
end