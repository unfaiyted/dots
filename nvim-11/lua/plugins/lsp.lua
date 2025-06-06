-- LSP configuration for nvim-11 with built-in LSP support
local vim = vim
return {
	-- Mason 2.0 for LSP server installation management
	{
		"mason-org/mason.nvim",
		event = {},
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		keys = {},
		lazy = false, -- Mason should not be lazy-loaded as per docs
		priority = 100, -- Load early
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
				width = 0.8,
				height = 0.9,
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		},
	},

	-- Mason integration with lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		event = {},
		cmd = {},
		keys = {},
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			-- List of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"pyright",
				"bashls",
				"jsonls",
				"yamlls",
				"svelte",
				"vtsls",
			},
			-- Auto-install configured servers (with lspconfig)
			automatic_installation = true,
      -- Automatically update LSP servers
      automatic_updates = true,
		},
	},

	-- blink.cmp integration with LSP
	{
		"saghen/blink.cmp",
		event = {},
		cmd = {},
		keys = {},
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- LSP Configuration with nvim-11's built-in LSP support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		opts = {},
		keys = {},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Load and setup LSP configurations from lua/lsp directory
			require("lsp").setup()
		end,
	},

	-- Additional LSP tools and UI
	{
		"folke/trouble.nvim",
		event = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix" },
		},
		opts = {},
	},
}
