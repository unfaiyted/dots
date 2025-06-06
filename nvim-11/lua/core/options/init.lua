-- Neovim options configuration
local opt = vim.opt
local vim = vim
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = "\\"

-- UI settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false
opt.laststatus = 3
opt.showcmd = false
opt.cmdheight = 1
opt.scrolloff = 10
opt.sidescrolloff = 5

-- Tabs & Indentation
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.softtabstop = 2 -- Number of spaces a tab counts for while editing
opt.shiftwidth = 2 -- Number of spaces for each step of indent
opt.expandtab = true -- Use spaces instead of tabs

opt.smartindent = true -- Smart auto-indenting
opt.breakindent = true -- Wrapped lines preserve indentation
opt.linebreak = true -- Break lines at word boundaries
opt.wrap = true -- Don't wrap lines

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- File handling
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.confirm = true
opt.autoread = true

-- Enable break indent (only applies when wrap is enabled)
vim.opt.breakindent = true

-- Folding (handled by nvim-ufo)
opt.fillchars:append({
  fold = " ",
  foldopen = "▾",
  foldsep = " ",
  foldclose = "▸",
})
opt.foldmethod = "manual"

-- Split windows
opt.splitbelow = true
opt.splitright = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Appearance
opt.termguicolors = true
opt.background = "dark"

-- Faster completion
opt.updatetime = 250
opt.timeoutlen = 300

-- Better clipboard
opt.clipboard = "unnamedplus"

-- Better wildmenu
opt.wildmode = "longest:full,full"

-- Mouse support
opt.mouse = "a"
