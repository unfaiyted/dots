return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      halt_on_error = false,
      split_direction = 'vertical',
      global_keymaps = {
        ['Send request'] = {
          '<LocalLeader>rr',
          function()
            require('kulala').run()
          end,
          desc = 'Send request',
        },
        ['Send all requests'] = {
          '<LocalLeader>ra',
          function()
            require('kulala').run_all()
          end,
          desc = 'Send all requests',
        },
      },
    },
  },
}
