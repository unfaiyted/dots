return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	config = function(_, opts)
		-- Force install regex treesitter parser
		vim.notify("Ensuring treesitter regex parser for snacks.picker...", vim.log.levels.INFO)

		-- Just ensure the parser is installed without checking
		require('nvim-treesitter.install').ensure_installed({"regex"})

		-- Setup snacks
		require("snacks").setup(opts)
	end,
}
