-- Aerial: A code outline window alternative to navbuddy
-- Provides a stable code outline navigation
return {
  'stevearc/aerial.nvim',
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", function() require("aerial").toggle({focus = true}) end, desc = "Aerial Toggle (Code Outline)" },
    { "<leader>nb", function() require("aerial").toggle({focus = true}) end, desc = "Code Outline (replaces Navbuddy)" },
  },
  opts = {
    -- Priority list of preferred backends for aerial
    backends = { "lsp", "treesitter", "markdown", "man" },

    layout = {
      -- Split window configuration
      default_direction = "float", -- Use float window by default
      -- Floating window settings
      placement = "edge", -- 'edge' or 'center'
      preserve_equality = false, -- Preserve window equality
      min_width = 40,
      max_width = 60
    },

    float = {
      relative = "cursor",
      max_height = 0.4,
      height = 0.3,
      width = 0.6,
      min_height = { 8, 0.1 }
    },
    -- Automatically focus aerial window when opened
    focus_on_open = true,

    on_attach = function(bufnr)
      -- Set up autocmd to focus the window when it opens
      vim.api.nvim_create_autocmd("User", {
        pattern = "AerialOpen",
        callback = function()
          -- Find and focus the aerial window
          for _, win in pairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match("aerial") then
              vim.api.nvim_set_current_win(win)
              break
            end
          end
        end,
        once = true,
      })
      return true
    end,

    -- UI customization
    close_behavior = "auto", -- Close when selecting a symbol
    close_on_select = true,  -- Close when selecting a symbol
    highlight_on_hover = true, -- Highlight the symbol on hover
    highlight_on_jump = 300, -- Highlight for 300ms after jump
    show_guides = true,      -- Show indent guides
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },

    -- Keymaps for aerial window
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["q"] = "actions.close",
      ["<Esc>"] = "actions.close",
      ["o"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["p"] = "actions.scroll",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["j"] = "actions.down",
      ["k"] = "actions.up",
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
    },

    -- LSP and treesitter integration
    attach_mode = "window", -- Attach to window
    disable_max_lines = 10000, -- Disable for large files
    disable_max_size = 1024 * 1024, -- Disable for files > 1MB
    lsp = {
      -- Customize how LSP symbols appear
      diagnostics_trigger_update = true,
      update_when_errors = true,
      update_delay = 300,
    },
    treesitter = {
      -- Advanced treesitter config
      update_delay = 300,
    },
    -- Symbol filtering
    filter_kind = {
      -- Include all symbol types
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
  },
}
