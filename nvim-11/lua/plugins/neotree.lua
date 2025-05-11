-- Neo-tree file explorer configuration
local vim = vim

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { 
      "<localleader>e", 
      "<cmd>Neotree toggle float<cr>", 
      desc = "Toggle Neo-tree Explorer" 
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    -- Load config from the separate neotree config file
    require('neo-tree').setup(require("config.neotree"))
  end,
}