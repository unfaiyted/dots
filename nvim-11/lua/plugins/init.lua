-- Plugin definitions for lazy.nvim

return {
	-- Plugin specs can be defined directly in this file
	-- or imported from separate modules

	-- Load treesitter fix for vim.validate deprecation
	{ import = "plugins.treesitter_fix" },

	-- Load TreeSitter navigation plugins with floating windows
	{ import = "plugins.symbols_outline" },
	{ import = "plugins.navbuddy" },
	{ import = "plugins.treesitter_context" },

	-- Load language specific plugins
	{ import = "plugins.go" },

	-- Load formatting plugins
	{ import = "plugins.formatter" },


	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false, -- load during startup
		priority = 1000, -- load before all other plugins
		config = function()
			-- Load the colorscheme
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-- Essential plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- UI improvements
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},

	-- Bufferline for better buffer management
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.bufferline")
		end,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neotree")
		end,
	},

	-- Fuzzy finder
	{
		import = "plugins.fuzzy",
	},

	-- Treesitter for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("config.treesitter")
		end,
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true, -- use default config
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
		config = true, -- use default config
	},

	-- Add/change/delete surrounding pairs
	{
		"kylechui/nvim-surround",
		keys = { "ys", "ds", "cs" },
		config = true, -- use default config
	},

	-- Better UI components
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("config.which-key")
		end,
	},

	-- LSP and Completion (add more plugins and configs as needed)

	-- Import completion and LSP configs from separate files
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },

	-- Code folding with nvim-ufo
	{ import = "plugins.folding" },

	-- File explorer with oil.nvim
	{ import = "plugins.oil" },
}

