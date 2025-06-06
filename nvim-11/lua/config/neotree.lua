-- Neo-tree configuration
return {
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  sort_case_insensitive = false,
  sort_function = nil,
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = "",
        modified  = "",
        deleted   = "✖",
        renamed   = "",
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  window = {
    position = "float",
    width = 40,
    height = 20,
    auto_clean_after_session_restore = true,
    float = {
      enable = true,
      quit_on_focus_loss = false, -- Don't close on focus loss
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * 0.5
        local window_h = screen_h * 0.6
        local center_x = (screen_w - window_w) / 2
        local center_y = (screen_h - window_h) / 2

        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = math.floor(window_w),
          height = math.floor(window_h),
          style = "minimal", -- No number column, etc.
          title = "Neo-tree", -- Add a title
          title_pos = "center", -- Center the title
        }
      end,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "none"
        }
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",

      -- Source navigation keys
      ["<"] = "prev_source",
      [">"] = "next_source",

      -- Quick switch between sources using capital letters
      ["F"] = "prev_source", -- Navigate to previous source
      ["B"] = "next_source", -- Navigate to next source
      ["G"] = "next_source", -- Alternative way to navigate
    }
  },
  sources = {"filesystem", "buffers", "git_status"},
  source_selector = {
    winbar = true,
    content_layout = "center",
    sources = {
      { source = "filesystem", display_name = " Files" },
      { source = "buffers", display_name = "󰈙 Buffers" },
      { source = "git_status", display_name = "󰊢 Git" },
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = true,
      hide_by_name = {
        "node_modules",
        ".git",
      },
      hide_by_pattern = {
        "*.meta",
        "*/src/*/tsconfig.json",
      },
      always_show = {
        ".gitignored",
        ".env",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
      never_show_by_pattern = {
        "*.meta",
      },
    },
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["<esc>"] = "close_window",
      },
      fuzzy_finder_mappings = {
        ["<down>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
      },
    },
  },
  buffers = {
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      }
    }
  }
}
