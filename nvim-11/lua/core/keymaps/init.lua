-- Keymaps configuration
-- Import only what we need from vim to avoid linter warnings
local keymap = vim.keymap.set
local diagnostic = vim.diagnostic
local opts = { noremap = true, silent = true }

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

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

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



-- Resize panel left and right
keymap('n', '<A-;>', '<cmd>vertical resize -5<CR>', { desc = 'Move panel divider left', silent = true })
keymap('n', "<A-'>", '<cmd>vertical resize +5<CR>', { desc = 'Move panel divider right', silent = true })

-- Window sizes
keymap('n', '<leader>=', '<C-w>=', { desc = 'Equalize window sizes', silent = true })

-- Create new splits
keymap('n', '<leader>\\', ':vsplit<CR>', { desc = 'Create vertical split', silent = true })
keymap('n', '<leader>-', ':split<CR>', { desc = 'Create horizontal split', silent = true })


-- Navigation between cursor positions (using g[ and g] to avoid conflicts)
keymap('n', 'g[', '<C-o>', { noremap = true, desc = 'Go back to last cursor position' })
keymap('n', 'g]', '<C-i>', { noremap = true, desc = 'Go forward to next cursor position' })

-- Goes to the next error
keymap('n', 'ge', function()
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
end, { desc = '[G]o to next [e]rror or diagnostic' })

