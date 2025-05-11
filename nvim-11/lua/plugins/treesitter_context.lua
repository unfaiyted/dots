-- TreeSitter context plugin (shows function context at top of window)
-- and TreeSitter Playground for viewing AST

return {
  -- TreeSitter context - keeps function signature visible at top of window
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        min_window_height = 10,
        line_numbers = true,
        multiline_threshold = 1,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
  
  -- TreeSitter Playground - view AST and nodes
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
    keys = {
      { "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", desc = "Toggle TreeSitter Playground" },
      { "<leader>th", "<cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Show TS Highlight under cursor" },
    },
  },
}