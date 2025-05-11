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
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.linebreak = true
opt.wrap = false

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
