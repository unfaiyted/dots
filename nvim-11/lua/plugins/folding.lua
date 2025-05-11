-- Folding configuration using nvim-ufo
return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    event = "BufReadPost",
    opts = {
      -- Folded region style
      open_fold_hl_timeout = 400,

      -- Close some common folds automatically when opening a buffer
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
        json = { "array" },
        yaml = { "imports" },
      },

      -- Determine which providers to use based on filetype
      provider_selector = function(bufnr, filetype, buftype)
        -- Some filetypes work better with specific providers
        local ft_providers = {
          vim = 'indent',
          python = {'indent'},
          git = '',
        }

        -- Check if we have a specific config for this filetype
        if ft_providers[filetype] then
          return ft_providers[filetype]
        end

        -- For most filetypes use lsp->treesitter->indent chain
        -- Use indent as fallback for treesitter as it's the most reliable
        return {'treesitter', 'indent'}
      end,

      -- Customize fold text
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d lines"):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)

          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)

            -- Add padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,

      -- Preview window configuration
      preview = {
        win_config = {
          border = "rounded",
          winblend = 12,
          winhighlight = "Normal:Normal",
          maxheight = 20
        },
        mappings = {
          scrollB = "",
          scrollF = "",
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          scrollE = "<C-e>",
          scrollY = "<C-y>",
          close = "q",
          switch = "<Tab>",
          trace = "<CR>",
        }
      }
    },

    init = function()
      -- Set folding options
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldcolumn = "1" -- '0' is also good

      -- Hide fold column in certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "neo-tree", "Trouble", "help", "dashboard" },
        callback = function()
          vim.opt_local.foldcolumn = "0"
        end
      })
    end,

    config = function(_, opts)
      -- Set up UFO
      require("ufo").setup(opts)

      -- Keymaps
      local ufo = require("ufo")

      -- Open/close all folds
      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)

      -- More advanced fold control
      vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
      vim.keymap.set("n", "zm", ufo.closeFoldsWith)

      -- K shows hover or opens fold
      vim.keymap.set("n", "K", function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          -- If no fold, trigger LSP hover
          vim.lsp.buf.hover()
        end
      end, { desc = "Hover or peek fold" })

      -- Override default z-key fold commands with ufo versions
      vim.keymap.set("n", "zc", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        ufo.closeFolds({ row })
      end)

      vim.keymap.set("n", "zo", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        ufo.openFolds({ row })
      end)
    end
  }
}
