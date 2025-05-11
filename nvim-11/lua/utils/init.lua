-- General utility functions

local M = {}

-- Check if a file or directory exists
M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

-- Check if a directory exists
M.is_dir = function(path)
  -- Add trailing slash to properly test directories
  return M.exists(path.."/")
end

-- Get visual selection
M.get_visual_selection = function()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

-- Set a keymap for multiple modes
M.map = function(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  
  if type(modes) == 'string' then
    modes = {modes}
  end
  
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Check if current Neovim version is at least the specified version
M.has_version = function(major, minor, patch)
  patch = patch or 0
  local actual = vim.version()
  return actual.major > major or
    (actual.major == major and actual.minor > minor) or
    (actual.major == major and actual.minor == minor and actual.patch >= patch)
end

-- Get highlight properties
M.get_hl = function(name, prop)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if not hl then return nil end
  return prop and hl[prop] or hl
end

-- Merge tables
M.merge_tables = function(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      M.merge_tables(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

-- Reload module and its submodules
M.reload_module = function(name)
  package.loaded[name] = nil
  
  -- Also reload all modules that match the pattern 'name.*'
  for module_name, _ in pairs(package.loaded) do
    if module_name:match("^" .. name .. "%.") then
      package.loaded[module_name] = nil
    end
  end
  
  return require(name)
end

return M