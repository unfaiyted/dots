-- Fuzzy finder configuration using fzf-lua

return {
  -- fzf-lua - powerful fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons" -- optional for icon support
    },
    priority = 100,                 -- load early
    cmd = "FzfLua",
    keys = {
      -- File and buffer navigation
      { "<leader><leader>", "<cmd>FzfLua files<CR>",                desc = "Find Files" },
      { "<leader>fo",       "<cmd>FzfLua oldfiles<CR>",             desc = "Recent Files" },
      { "<leader>fb",       "<cmd>FzfLua buffers<CR>",              desc = "Buffers" },
      { "<leader>fh",       "<cmd>FzfLua help_tags<CR>",            desc = "Help Tags" },

      -- Search
      { "<leader>fg",       "<cmd>FzfLua grep<CR>",                 desc = "Grep" },
      { "<leader>fp",       "<cmd>FzfLua live_grep<CR>",            desc = "Live Grep" },
      { "<lrader>fw",       "<cmd>FzfLua grep_cword<CR>",           desc = "Grep Word Under Cursor" },

      -- LSP
      { "<leader>gs",       "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Document Symbols" },
      { "<leader>gr",       "<cmd>FzfLua lsp_references<CR>",       desc = "References" },
      { "<leader>gd",       "<cmd>FzfLua lsp_definitions<CR>",      desc = "Definitions" },
      { "<leader>gi",       "<cmd>FzfLua lsp_implementations<CR>",  desc = "Implementations" },
      { "<leader>gt",       "<cmd>FzfLua lsp_typedefs<CR>",         desc = "Type Definitions" },

      -- Git
      { "<leader>gc",       "<cmd>FzfLua git_commits<CR>",          desc = "Git Commits" },
      { "<leader>gs",       "<cmd>FzfLua git_status<CR>",           desc = "Git Status" },
      { "<leader>gb",       "<cmd>FzfLua git_branches<CR>",         desc = "Git Branches" },

      -- Misc
      { "<leader>fk",       "<cmd>FzfLua keymaps<CR>",              desc = "Keymaps" },
      { "<leader>fc",       "<cmd>FzfLua commands<CR>",             desc = "Commands" },
      { "<leader>fo",       "<cmd>FzfLua colorschemes<CR>",         desc = "Colorschemes" },
    },
    opts = {
      -- Use the "fzf-native" profile for best performance
      "fzf-native",

      -- Global options
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          hidden = "nohidden",
          vertical = "down:45%",
          horizontal = "right:60%",
          layout = "flex",
          flip_columns = 120,
        },
      },
      async_or_timeout = 3000,

      -- Keymap settings
      keymap = {
        builtin = {
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },

      -- Default options for specific commands
      files = {
        prompt = "Files❯ ",
        git_icons = true,
        file_icons = true,
        color_icons = true,
        find_opts = [[-type f -not -path "*/\.git/*" -not -path "*/node_modules/*"]],
        fd_opts = "--color=never --type f --hidden --exclude .git --exclude node_modules",
        rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!node_modules'",
      },

      grep = {
        prompt = "Grep❯ ",
        input_prompt = "Grep For❯ ",
        git_icons = true,
        file_icons = true,
        color_icons = true,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
      },

      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,
        color_icons = true,
        sort_lastused = true,
      },

      lsp = {
        prompt_postfix = "❯ ",
        file_icons = true,
        git_icons = false,
        lsp_icons = true,
        ui_select = true,
        formatter = nil,
      },
    },
    config = function(_, opts)
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup(opts)
      -- Register as the UI for vim.ui.select
      fzf_lua.register_ui_select()

      -- Set common actions with the actions module (now safely loaded)
      local actions = fzf_lua.actions
      local common_actions = {
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
      }




      -- Apply actions to relevant commands
      local command_actions = fzf_lua.config.globals.actions or {}
      command_actions.files = vim.tbl_extend("force", command_actions.files or {}, common_actions)
      command_actions.buffers = vim.tbl_extend("force", command_actions.buffers or {},
        vim.tbl_extend("force", common_actions, {
          ["ctrl-x"] = { fn = actions.buf_del, reload = true }
        })
      )
      fzf_lua.config.globals.actions = command_actions
    end,
  },
}
