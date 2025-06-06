-- Keymaps configuration
-- Import only what we need from vim to avoid linter warnings
local keymap = vim.keymap.set
local diagnostic = vim.diagnostic
local opts = { noremap = true, silent = true }

-- Load DBUI keymaps
-- Load terminal keymaps
require("core.keymaps.terminal").setup()

-- Neo-tree is now configured via plugins.neotree using <localleader>e

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better paste (doesn`t replace default register)
keymap("v", "p", '"_dP', opts)

-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<leader>c", ":bd<CR>", opts)

-- Better saving
keymap("n", "<leader>w", ":w<CR>", opts)

-- Quick exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Resize panels with Alt keys
keymap("n", "<A-j>", "<cmd>resize +5<CR>", { desc = "Increase window height", silent = true })
keymap("n", "<A-k>", "<cmd>resize -5<CR>", { desc = "Decrease window height", silent = true })
keymap("n", "<A-h>", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width", silent = true })
keymap("n", "<A-l>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width", silent = true })

-- Window sizes
keymap("n", "<leader>=", "<C-w>=", { desc = "Equalize window sizes", silent = true })

-- Create new splits
keymap("n", "<leader>\\", ":vsplit<CR>", { desc = "Create vertical split", silent = true })
keymap("n", "<leader>-", ":split<CR>", { desc = "Create horizontal split", silent = true })
vim.keymap.set("n", "<leader>_", ":vsplit<CR>", { desc = "Vertical Split" })

-- Navigation between cursor positions (using g[ and g] to avoid conflicts)
keymap("n", "g[", "<C-o>", { noremap = true, desc = "Go back to last cursor position" })
keymap("n", "g]", "<C-i>", { noremap = true, desc = "Go forward to next cursor position" })

-- Goes to the next error
keymap("n", "ge", function()
  local has_errors = false

  -- First check if there are any errors
  for _, diag in ipairs(diagnostic.get(0)) do
    if diag.severity == diagnostic.severity.ERROR then
      has_errors = true
      break
    end
  end

  -- If there are errors, go to next error, otherwise go to next diagnostic
  if has_errors then
    diagnostic.jump({ severity = diagnostic.severity.ERROR, forward = true, count = 1 })
  else
    diagnostic.jump({ forward = true, count = 1 })
  end
end, { desc = "[G]o to next [e]rror or diagnostic" })

-- Window maximize toggle with Ctrl+w +
local maximized = false
function ToggleMaximize()
  if maximized then
    vim.cmd("wincmd =")
    maximized = false
  else
    vim.cmd("wincmd _|wincmd |")
    maximized = true
  end
end

vim.keymap.set("n", "<leader>+", ToggleMaximize, { desc = "Toggle window maximize", silent = true })

-- Copy the path of the current buffer to the clipboard
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy current buffer path" })

vim.keymap.set('x', '<leader>rr', function()
        local saved_unnamed_register = vim.fn.getreg '"'
        vim.cmd [[normal! "xy]]
        local text = vim.fn.getreg 'x'
        vim.fn.setreg('"', saved_unnamed_register)

        -- Escape special characters
        local escaped_text = vim.fn.escape(text, '/\\.*$^~[]')

        -- Set up the substitution command with the escaped text
        vim.fn.feedkeys(':%s/' .. escaped_text .. '/', 'n')
end, { noremap = true, desc = 'Substitute visual selection' })


vim.keymap.set('n', '<leader>fp', function()
    local fzf = require 'fzf-lua'
      fzf.live_grep()
    end, { desc = '[F]ind text in [p]roject' })
