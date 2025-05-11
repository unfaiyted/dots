-- Go language support configuration
return {
  -- Go language plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()',
    event = { "CmdlineEnter" },
    config = function()
      require("go").setup({
        -- Gopls configuration
        lsp_cfg = {
          settings = {
            gopls = {
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                nilness = true,
                shadow = true,
                unusedwrite = true,
                useany = true,
              },
              staticcheck = true,
              gofumpt = true,
              semanticTokens = true,
            },
          },
        },
        -- Format on save
        format_on_save = true,
        -- Set to true: use gopls to format
        -- Set to false: use other formatter_tool
        formatter_on_save = true,
        -- Default formatter
        formatter = 'gofumpt',
        -- Maintain the imports group
        maintain_imports_group = true,
        -- Auto-format imports on save
        format_imports_on_save = true,
        -- Test flags
        test_flags = { "-v" },
        -- Diagnostic configuration
        diagnostic = {
          virtual_text = {
            spacing = 0,
            prefix = "",
          },
          underline = true,
          update_in_insert = true,
        },
        -- Icon configuration
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        -- Debug adaptor configuration
        dap_debug = true,
        dap_debug_gui = true,
        -- Keymappings for leader commands
        go_keymap = false, -- Set to false to disable go.nvim's default keymaps
        -- Custom key mappings
        diagnostic_signs = {
          error = "", -- error sign
          warn = "", -- warning sign
          hint = "", -- hint sign
          info = "", -- info sign
        },
      })

      -- Custom keymaps for Go functionality
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- Go specific mappings
      map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Go to alternate file")
      map("n", "<leader>gat", "<cmd>GoAltV<CR>", "Go to alternate file in vsplit")
      map("n", "<leader>gc", "<cmd>GoCoverage<CR>", "Show test coverage")
      map("n", "<leader>gt", "<cmd>GoTest<CR>", "Run tests")
      map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", "Run test for current function")
      map("n", "<leader>gtp", "<cmd>GoTestPkg<CR>", "Run tests for package")
      map("n", "<leader>gi", "<cmd>GoImport<CR>", "Import Go package")
      map("n", "<leader>gim", "<cmd>GoImpl<CR>", "Generate interface implementation")
      map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", "Fill struct with zero values")
      map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", "Fill struct with zero values")
      map("n", "<leader>gts", "<cmd>GoAddTag<CR>", "Add struct tags")
      map("n", "<leader>grts", "<cmd>GoRmTag<CR>", "Remove struct tags")
      map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", "Fill struct with zero values")
      map("n", "<leader>gft", "<cmd>GoFixTest<CR>", "Fix test")
      map("n", "<leader>ggem", "<cmd>GoGenEmptyMethod<CR>", "Generate empty methods for interface")
      
      -- Auto-commands for Go files
      local autocmd = vim.api.nvim_create_autocmd
      local go_group = vim.api.nvim_create_augroup("GoGroup", { clear = true })

      -- Format and organize imports on save
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = go_group,
      })
    end,
  },

  -- Add gopls to our LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not opts.servers then opts.servers = {} end
      opts.servers.gopls = {}
      table.insert(opts.ensure_installed or {}, "gopls")
    end
  },

  -- Add Go to treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
      end
    end,
  },
}