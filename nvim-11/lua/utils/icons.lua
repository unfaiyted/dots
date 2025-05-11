-- Icons for UI components

local M = {}

-- Icons for LSP kinds
M.kinds = {
  Array = "󰅪",
  Boolean = "⊨",
  Class = "󰠱",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "󰆧",
  Enum = "󰕘",
  EnumMember = "󰠰",
  Event = "󰥔",
  Field = "󰜢",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰊕",
  Interface = "󰠯",
  Key = "󰌋",
  Keyword = "󰌋",
  Method = "󰆧",
  Module = "󰏗",
  Namespace = "󰅩",
  Null = "󰟢",
  Number = "#",
  Object = "󰅩",
  Operator = "󰆕",
  Package = "󰏗",
  Property = "󰜢",
  Reference = "󰈇",
  Snippet = "󰩫",
  String = "󰀬",
  Struct = "󰙅",
  Text = "󰉿",
  TypeParameter = "󰊄",
  Unit = "󰑭",
  Value = "󰎠",
  Variable = "󰂡",
}

-- Icons for diagnostics
M.diagnostics = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " ",
}

-- Git diff status icons
M.git = {
  Add = "",
  Mod = "",
  Remove = "",
  Ignore = "",
  Rename = "",
  Diff = "",
  Repo = "",
  Merge = "",
  Branch = "",
}

-- UI icons
M.ui = {
  CircleFilled = "●",
  CircleEmpty = "○",
  ArrowRight = "",
  ArrowLeft = "",
  ArrowDown = "",
  ArrowUp = "",
  Block = "█",
  BigCircle = "◯",
  BigUnfilledCircle = "◯",
  Close = "✖",
  Check = "✓",
  Fire = "󰈸",
  Star = "★",
  Lightbulb = "󰌵",
  Project = "󰉋",
  Dashboard = "󰕮",
  History = "󰋚",
  Comment = "󰆈",
  Search = "󰍉",
  Settings = "󰒓",
  BookMark = "󰃀",
  Telescope = "󰭎",
  Kickstart = "󰜌",
  Package = "󰏗",
  Copilot = "󰚩",
}

return M