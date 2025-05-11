-- Formatter plugin configuration
-- Provides automatic formatting on save for various languages
local vim = vim
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Manual formatting
        "<leader>fmt",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define formatters
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        svelte = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        sh = { "shfmt" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- Add more languages as needed

        -- Fallback formatter for any filetype
        ["*"] = { "trim_whitespace" },
      },

      -- Format on save
      format_on_save = {
        -- These options will be passed to conform.format()
        lsp_fallback = true,
        lsp_format = "fallback",
        timeout_ms = 500,

        -- For multiple formatters, use this option instead of the nested syntax
        quiet = true,
        stop_after_first = false, -- Run all formatters
      },

      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },

      -- Alert when formatter is not available
      notify_on_error = true,
    },
    init = function()
      -- Register conform formatting with LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("conform_lsp_attach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- Only attach to clients that support document formatting
          if client and client.server_capabilities and client.server_capabilities.documentFormattingProvider then
            -- Create buffer-local keymaps for formatting
            vim.keymap.set("n", "<leader>f", function()
              require("conform").format({ bufnr = bufnr, lsp_fallback = true })
            end, { buffer = bufnr, desc = "Format document" })
          end
        end,
      })
    end,
  },

  -- Use null-ls as a fallback for any formatters not supported by conform.nvim
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- Go additional tools
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,

          -- Python
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.mypy,

          -- Lua with custom configuration
          -- null_ls.builtins.diagnostics.selene.with({
          --   -- Use our custom selene configuration from the project root
          --   cwd = vim.fn.expand("~/.config/nvim-11"),
          --   extra_args = { "--config", "selene.toml" }
          -- }),

          -- Spelling and grammar
          null_ls.builtins.diagnostics.codespell,

          -- Markdown
          null_ls.builtins.diagnostics.markdownlint,

          -- Shell
          -- Commenting out shellcheck as it's also giving warnings
          -- null_ls.builtins.diagnostics.shellcheck,

          -- Svelte
          -- Commenting out eslint as it seems to be missing from null_ls.builtins.diagnostics
          -- null_ls.builtins.diagnostics.eslint.with({
          --   filetypes = {"javascript", "typescript", "svelte"},
          -- }),

          -- Add more sources as needed
        },
      }
    end,
  },
}
