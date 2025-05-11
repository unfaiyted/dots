-- Compatibility layer for deprecated Neovim API functions
-- This file should be loaded early in the init process

local M = {}

M.setup = function()
  -- Create non-deprecated aliases for deprecated functions
  vim.tbl_islist = vim.islist

  -- We won't monkey-patch vim.validate as it's causing issues with core Neovim functions
  -- Instead, we'll provide a compatibility function that plugins can use explicitly
  M.validate = function(tbl)
    -- Compatible with the old style: vim.validate({[name] = {value, "type"|func, optional, msg}})
    for name, spec in pairs(tbl) do
      local value, validator = spec[1], spec[2]
      local optional = spec[3] == true
      local message = spec[4]

      if value == nil and not optional then
        error(string.format("'%s' is required", name))
      end

      if value ~= nil then
        local valid = true
        if type(validator) == "string" then
          valid = type(value) == validator
        elseif type(validator) == "function" then
          valid = validator(value)
        end

        if not valid then
          error(string.format("'%s' %s", name, message or "is invalid"))
        end
      end
    end
  end

  -- Any other compatibility fixes can be added here
end

return M