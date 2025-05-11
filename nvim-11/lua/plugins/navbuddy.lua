-- Navigation popup for code symbols using TreeSitter and LSP
-- Adds a floating window interface for navigating code structure

return {
  "hasansujon786/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    { "MunifTanjim/nui.nvim", version = "*" } -- Latest stable version
  },
  enabled = false, -- Temporarily disable until issues are fixed
  keys = {
    { "<leader>nb", "<cmd>Navbuddy<CR>", desc = "Navigation Buddy (Code Outline)" },
  },
  config = function()
    local navbuddy = require("nvim-navbuddy")
    local actions = require("nvim-navbuddy.actions")

    navbuddy.setup({
      window = {
        border = "rounded",  -- "rounded", "double", "solid", "none"
        size = "60%",       -- Or table format example: { height = "40%", width = "100%" }
        position = "50%",   -- Or table format example: { row = "100%", col = "0%" }
        -- scrolloff = 5,   -- Temporarily comment out to fix nui.nvim error
        sections = {
          left = {
            size = "20%",
            border = nil,   -- You can set border style for each section individually as well.
          },
          mid = {
            size = "40%",
            border = nil,
          },
          right = {
            -- No size option for right most section. It fills to
            -- available space.
            border = nil,
            preview = "always",  -- Right section can show previews too.
                                -- Options: "leaf", "always" or "never"
          }
        },
      },
      node_markers = {
        enabled = true,
        icons = {
          leaf = "  ",
          leaf_selected = " → ",
          branch = " ",
        },
      },
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰠱 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘 ",
        Interface = "󰕘 ",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
      lsp = {
        auto_attach = true   -- If set to true, automatically attach to newly initialized LSP servers
      },
      source_buffer = {
        follow_node = true,   -- Keep the current node in focus on the source buffer
        highlight = true,     -- Highlight the currently focused node
        reorient = "smart",   -- "smart", "top", "mid" or "none"
        -- scrolloff = nil,   -- Temporarily comment out to fix nui.nvim error
      },
      mappings = {
        ["<esc>"] = actions.close,        -- Close and cursor to original location
        ["q"] = actions.close,
        ["<Down>"] = actions.next_sibling,     -- down
        ["<Up>"] = actions.previous_sibling, -- up
        ["<Left>"] = actions.parent,          -- Move to left panel
        ["<Right>"] = actions.children,       -- Move to right panel
        ["h"] = actions.parent,
        ["l"] = actions.children,
        ["j"] = actions.next_sibling,
        ["k"] = actions.previous_sibling,
        ["<enter>"] = actions.select,         -- Open the selected symbol
        ["v"] = actions.visual_name,        -- Visual selection of name
        ["V"] = actions.visual_scope,       -- Visual selection of scope
        ["y"] = actions.yank_name,          -- Yank the name to system clipboard
        ["Y"] = actions.yank_scope,         -- Yank the scope to system clipboard
        ["i"] = actions.insert_name,        -- Insert at start of name
        ["I"] = actions.insert_scope,       -- Insert at start of scope
        ["a"] = actions.append_name,        -- Insert at end of name
        ["A"] = actions.append_scope,       -- Insert at end of scope
        ["r"] = actions.rename,             -- Rename currently focused symbol
        ["d"] = actions.delete,             -- Delete scope
        ["f"] = actions.fold_create,        -- Create fold of current scope
        ["F"] = actions.fold_delete,        -- Delete fold of current scope
        ["c"] = actions.comment,            -- Comment out current scope
        ["<home>"] = actions.root,              -- Move to root
        ["<C-s>"] = actions.toggle_preview,      -- Toggle preview
        ["<C-v>"] = actions.vsplit,           -- Open in vsplit
        ["<C-h>"] = actions.split,            -- Open in split
        ["<C-t>"] = actions.tabnew,           -- Open in new tab
        ["<C-o>"] = actions.scroll_down,      -- Scroll down in preview
        ["<C-i>"] = actions.scroll_up,        -- Scroll up in preview
        ["gd"] = actions.definition,        -- Go to definition
        ["gr"] = actions.references,        -- Go to references
        ["H"] = actions.help,               -- Open help
      },
    })

    -- Auto-attach to LSP servers
    require("nvim-navic").setup({
      lsp = {
        auto_attach = true,
      }
    })
  end,
}
