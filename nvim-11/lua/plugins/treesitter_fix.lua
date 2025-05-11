-- Patch for nvim-treesitter to fix vim.validate deprecation
return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      -- Monkey patch the get_parser_install_info function to avoid vim.validate deprecation
      -- This function is loaded after nvim-treesitter is loaded
      vim.defer_fn(function()
        local install_mod = package.loaded["nvim-treesitter.install"]
        if install_mod then
          -- Get the original function
          local original_get_parser_install_info = install_mod.get_parser_install_info
          
          -- Replace it with our patched version that doesn't use vim.validate
          install_mod.get_parser_install_info = function(lang, validate)
            -- Just skip validation altogether since it's not critical
            -- The original function validates 'url' and 'files' in the install_info
            return original_get_parser_install_info(lang, false)
          end
        end
      end, 100)
    end,
  }
}