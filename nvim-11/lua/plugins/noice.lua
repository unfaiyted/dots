return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      hover = {
        silent = true,
        ---@type NoiceViewOptions
        opts = {
          border = 'rounded',
        },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
}
