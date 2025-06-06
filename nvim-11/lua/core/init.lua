-- Core configuration init
-- Load core Neovim settings

-- Load compatibility layer for deprecated Neovim API functions
require("core.compat").setup()

-- Load options (vim settings)
require("core.options")

-- Load keymaps
require("core.keymaps")

-- Load autocommands
require("core.autocmds")
