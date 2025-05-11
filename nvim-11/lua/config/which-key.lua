-- Which-key configuration

local which_key = require("which-key")

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,       -- adds help for motions
      text_objects = true,  -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local mappings = {
  ["<leader>"] = {
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<cr>", "Find Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    },
    e = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
    w = { "<cmd>w!<CR>", "Save" },
    q = { "<cmd>confirm q<CR>", "Quit" },
    c = { "<cmd>bd<CR>", "Close Buffer" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    s = { name = "Search" },
    g = { name = "Git" },
    l = { name = "LSP" },
    t = { name = "Terminal" },
    r = { name = "Run" },
    d = { name = "Debug" },
    x = {
      name = "Diagnostics",
      x = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
    },
  },
}

return {
  setup = function()
    which_key.setup(setup)
    which_key.register(mappings)
  end
}