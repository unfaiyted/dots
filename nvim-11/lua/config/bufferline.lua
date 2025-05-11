-- Bufferline configuration

return {
  options = {
    numbers = "none",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
    diagnostics_indicator = function(_, _, diag)
      local icons = require("utils.icons").diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
      }
    },
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
  }
}