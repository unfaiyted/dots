-- Completion plugins configuration using blink.cmp
return {
	-- blink.cmp - modern completion engine
		"saghen/blink.cmp",
    lazy = false,
		-- Optional: provides snippets for the snippet source
		dependencies = {
      "rafamadriz/friendly-snippets",
      -- Add blink.compat for nvim-cmp sources compatibility
      "supermaven-inc/supermaven-nvim",
      "saghen/blink.compat",
    },

		-- Use a release tag to download pre-built binaries
		version = "*",
		-- Build from source option, commented out by default
		-- build = 'cargo build --release',

		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- Only show the documentation popup when manually triggered
			completion = {
        menu = { max_height = 18 },

        list = {
         selection = {
           preselect = function(ctx)
            return ctx.mode == 'default' and true or false
          end,
        },
      },
        documentation = { auto_show = false } },
			-- Default list of enabled providers
			sources = {
				default = { "lsp", "path", "snippets", "buffer","supermaven"},
        providers = {
         lsp = {
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return not (item.labelDetails and item.labelDetails.description and string.find(item.labelDetails.description, 'lucide'))
            end, items)
          end,
          async = true,
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          -- max_items = 20,
        },
        -- codecompanion = {
        --   name = 'CodeCompanion',
        --   module = 'codecompanion.providers.completion.blink',
        --   enabled = true,
        -- },
        supermaven = {
          name = 'supermaven',
          module = "blink.compat.source",
          score_offset = 100,
          async = true,
        },
        },
			},

			-- Rust fuzzy matcher for typo resistance and better performance
			-- Fallback to Lua implementation when Rust fuzzy matcher is not available
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	}
