-- Autocommands configuration
local vim = vim
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Load the formatting autocmds
require("core.autocmds.format")

-- Load DBUI autocmds
require("core.autocmds.dbui")

-- Load PostgreSQL helpers
require("core.autocmds.postgres")

-- Load JSON auto-formatter
require("core.autocmds.json_listener")

-- General settings group
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Resize splits when window resized
autocmd("VimResized", {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Auto create dir when saving a file where dir doesn't exist
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- File type specific settings
local filetypes = augroup("FileTypeSettings", { clear = true })

-- Detect HTTP files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { "*.http", "*.rest" },
  callback = function()
    vim.opt_local.filetype = "http"
  end,
})

-- Apply custom highlighting for HTTP files
autocmd("FileType", {
  group = filetypes,
  pattern = "http",
  callback = function()
    -- Force treesitter to use the http parser
    vim.cmd("TSBufEnable highlight")

    -- Use nvim-treesitter API to set the parser
    require("nvim-treesitter.parsers").get_parser_configs().http = { filetype = "http" }

    -- Apply HTTP-specific highlighting directly
    -- Link HTTP tokens to existing highlight groups for better visibility
    -- vim.api.nvim_set_hl(0, "@http.header", { link = "Special" })
    -- vim.api.nvim_set_hl(0, "@http.method", { link = "Statement" })
    -- vim.api.nvim_set_hl(0, "@http.url", { link = "Underlined" })
    -- vim.api.nvim_set_hl(0, "@http.content_type", { link = "Type" })
    -- vim.api.nvim_set_hl(0, "@http.version", { link = "Number" })
    -- vim.api.nvim_set_hl(0, "@http.status", { link = "Number" })
    -- vim.api.nvim_set_hl(0, "@http.comment", { link = "Comment" })
    -- vim.api.nvim_set_hl(0, "@http.variable", { link = "Identifier" })
    -- vim.api.nvim_set_hl(0, "@http.json_body", { link = "String" })
    -- vim.api.nvim_set_hl(0, "@http.graphql", { link = "String" })
    --
    -- Set indentation for HTTP files (2 spaces)
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Force Svelte file type recognition and highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { "*.svelte" },
  callback = function()
    vim.opt_local.filetype = "svelte"
  end,
})

-- Terraform file type recognition
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { "*.tf", "*.tfvars", "*.tfvars.json" },
  callback = function()
    vim.opt_local.filetype = "terraform"
  end,
})

-- Ansible file type recognition
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetypes,
  pattern = { "**/playbooks/*.yml", "**/roles/*.yml", "*/ansible/*.yml", "**/tasks/*.yml", "**/handlers/*.yml", "**/meta/*.yml", "playbook.yaml", "playbook.yml" },
  callback = function()
    vim.opt_local.filetype = "yaml.ansible"
  end,
})

-- Apply Terraform-specific settings and force TreeSitter highlighting
autocmd("FileType", {
  group = filetypes,
  pattern = "terraform",
  callback = function()
    -- Force treesitter to use the terraform parser
    vim.cmd("TSBufEnable highlight")

    -- Explicitly set the parser for this buffer
    require("nvim-treesitter.parsers").get_parser_configs().terraform = { filetype = "terraform" }
    
    -- Set indentation for Terraform files (2 spaces)
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Apply Svelte-specific settings and force TreeSitter highlighting
autocmd("FileType", {
  group = filetypes,
  pattern = "svelte",
  callback = function()
    -- Force treesitter to use the svelte parser
    vim.cmd("TSBufEnable highlight")

    -- Explicitly set the parser for this buffer
    require("nvim-treesitter.parsers").get_parser_configs().svelte = { filetype = "svelte" }

    -- Set indentation for Svelte files (2 spaces)
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Set indentation for specific file types
autocmd("FileType", {
  group = filetypes,
  pattern = { "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

autocmd("FileType", {
  group = filetypes,
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Go indentation settings (tabs, 8 spaces)
autocmd("FileType", {
  group = filetypes,
  pattern = { "go" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = false -- Use tabs, not spaces
  end,
})
