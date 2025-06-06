-- Svelte specific plugins and configuration
local vim = vim

return {
  -- Svelte-specific plugin
  {
    -- "leafOfTree/vim-svelte-plugin",
    -- event = { "BufReadPre", "BufNewFile" },
    -- ft = { "svelte" },
    -- opts = {},
    -- config = function()
    --   -- Set up filetype detection
    --   vim.g.vim_svelte_plugin_load_full_syntax = 1
    --   vim.g.vim_svelte_plugin_use_typescript = 1
    --   vim.g.vim_svelte_plugin_use_sass = 1
    -- end,
  },

  -- Emmet support for Svelte
  {
  --   "mattn/emmet-vim",
  --   event = "InsertEnter",
  --   ft = { "html", "css", "javascript", "typescript", "svelte" },
  --   config = function()
  --     vim.g.user_emmet_leader_key = ','  -- Change the default emmet leader key
  --     vim.g.user_emmet_settings = {
  --       svelte = {
  --         extends = 'html',
  --       },
  --     }
  --   end,
  },
}
