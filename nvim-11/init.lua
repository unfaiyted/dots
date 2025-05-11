-- Entry point for Neovim configuration
-- Author: faiyt
-- License: MIT
-- Last Changed: 2025-05-09

-- Load globals first to avoid linter/LSP issues
require("core.globals")

-- Load core settings
require("core")

-- Bootstrap lazy.nvim plugin manager
require("core.lazy")

-- Load plugins
require("plugins")