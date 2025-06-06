-- Go language support configuration
return {
{
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Force Go syntax highlighting with stronger configuration
      vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
        pattern = { "*.go" },
        callback = function()
          -- Force Go syntax highlighting
          vim.cmd("setlocal syntax=go")

          -- Ensure the filetype is correctly set
          vim.bo.filetype = "go"

          -- Force treesitter parser to be Go
          vim.treesitter.start(vim.api.nvim_get_current_buf(), "go")

          -- Explicitly enable treesitter highlighting
          vim.cmd("TSEnable highlight")

          -- Additional settings to ensure syntax highlighting works
          vim.opt_local.syntax = "ON"
        end,
      })
    end,
  }
}
