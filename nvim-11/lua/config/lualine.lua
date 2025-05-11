-- Lualine configuration
local icons = require('utils.icons')

return {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = { "dashboard", "alpha", "starter" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      { 'mode', icon = '' }
    },
    lualine_b = {
      { 'branch', icon = icons.git.Branch },
      {
        'diff',
        symbols = {
          added = icons.git.Add,
          modified = icons.git.Mod,
          removed = icons.git.Remove,
        },
      },
    },
    lualine_c = {
      {
        'diagnostics',
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
      { 'filename', path = 1, symbols = { modified = '  ', readonly = '  ', unnamed = '[No Name]' } },
    },
    lualine_x = {
      {
        function() return require("blink.cmp").status() end,
        cond = function() return package.loaded["blink.cmp"] ~= nil end,
      },
      {
        function()
          local lsp_names = {}
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(lsp_names, client.name)
          end
          return " " .. table.concat(lsp_names, ", ")
        end,
        cond = function() return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil end,
      },
      { 'encoding' },
      { 'fileformat' },
      { 'filetype', icon = { align = 'right' } },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { 'neo-tree', 'trouble', 'lazy' }
}
