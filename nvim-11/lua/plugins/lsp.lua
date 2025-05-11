-- LSP configuration for nvim-11 with built-in LSP support

return {
	-- Mason 2.0 for LSP server installation management
	{
		"mason-org/mason.nvim",
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
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			-- List of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"pyright",
				"tsserver",
				"bashls",
				"jsonls",
				"yamlls",
			},
			-- Auto-install configured servers (with lspconfig)
			automatic_installation = true,
		},
	},

	-- blink.cmp integration with LSP
	{
		"saghen/blink.cmp",
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
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Configure LSP using nvim-11's built-in LSP support

			-- Enable all the servers with vim.lsp.enable
			local servers = {
				"lua_ls",
				"pyright",
				"tsserver",
				"bashls",
				"jsonls",
				"yamlls",
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			-- Configure specific LSP server settings
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			-- Add blink.cmp's LSP capabilities to all servers
			local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Apply blink.cmp capabilities to all servers
			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = blink_capabilities,
				})
			end

			-- Configure diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			-- Configure LSP handlers
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- Set up keymaps for LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true, silent = true }

					-- Set key mappings
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})
		end,
	},

	-- Additional LSP tools and UI
	{
		"folke/trouble.nvim",
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

