-- Auto-formatting configuration
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Format on save group
local format_group = augroup("FormatOnSave", { clear = true })

-- Format specific filetypes using LSP where available
autocmd("BufWritePre", {
  group = format_group,
  pattern = {
    "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.scss", "*.html", "*.json", "*.yaml", "*.yml",
    "*.lua", "*.py", "*.go", "*.rs", "*.c", "*.cpp", "*.h", "*.hpp"
  },
  callback = function()
    -- Prefer conform.nvim for formatting
    local conform_available, conform = pcall(require, "conform")
    if conform_available then
      -- Mark the buffer as "being formatted" to avoid double formatting
      vim.b[vim.api.nvim_get_current_buf()].conform_already_formatted_on_save = true
      return
    end
    
    -- Fall back to LSP formatting if conform isn't available
    local has_lsp_format_capability = false
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Check if any attached LSP server has formatting capability
    for _, client in pairs(vim.lsp.buf_get_clients(bufnr)) do
      if client.server_capabilities.documentFormattingProvider then
        has_lsp_format_capability = true
        break
      end
    end
    
    if has_lsp_format_capability then
      vim.lsp.buf.format({ 
        async = false,
        timeout_ms = 2000,
      })
    end
  end,
})

-- Special case for Go files that aren't handled by conform.nvim
autocmd("BufWritePre", {
  group = format_group,
  pattern = "*.go",
  callback = function()
    -- Skip if conform.nvim is available or go.nvim is available
    local conform_available = pcall(require, "conform")
    local go_available = pcall(require, "go")
    
    if conform_available or go_available then
      return
    end
    
    -- Fall back to gofmt if neither go.nvim nor conform.nvim is available
    local output = vim.fn.system("gofmt -s " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
    if vim.v.shell_error == 0 then
      local current_pos = vim.fn.getpos(".")
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(output, "\n"))
      vim.fn.setpos(".", current_pos)
    end
  end,
})