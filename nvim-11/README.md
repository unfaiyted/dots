# Neovim Configuration

A clean, modern Neovim configuration using the latest Neovim 0.11+ features.

## Features

- **Modern Structure**: Organized, modular configuration
- **Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management
- **Completion**: Powered by [blink.cmp](https://github.com/saghen/blink.cmp) (modern alternative to nvim-cmp)
- **LSP Support**: Native Neovim 0.11+ LSP integration with `vim.lsp.enable`
- **Fuzzy Finding**: [fzf-lua](https://github.com/ibhagwan/fzf-lua) for fast, powerful searching
- **File Navigation**: [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) for file browsing
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for advanced highlighting
- **UI**: Clean status line with [lualine](https://github.com/nvim-lualine/lualine.nvim)

## Structure

```
~/.config/nvim-11/
├── init.lua                 # Main entry point
├── lua/
│   ├── core/                # Core Neovim settings
│   │   ├── autocmds/        # Autocommands
│   │   ├── keymaps/         # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── options/         # Neovim options
│   ├── plugins/             # Plugin specifications
│   │   ├── completion.lua   # Completion plugin config
│   │   ├── fuzzy.lua        # Fuzzy finder config
│   │   ├── init.lua         # Main plugin list
│   │   └── lsp.lua          # LSP configuration
│   ├── config/              # Plugin configurations
│   │   ├── lualine.lua      # Status line config
│   │   ├── bufferline.lua   # Buffer line config
│   │   ├── neotree.lua      # File explorer config
│   │   ├── treesitter.lua   # Syntax highlighting config
│   │   └── which-key.lua    # Key binding help
│   └── utils/               # Utility functions
│       ├── icons.lua        # Icons for UI components
│       └── init.lua         # General utilities
```

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/username/nvim-11-config.git ~/.config/nvim-11
   ```

2. Start Neovim:
   ```bash
   nvim
   ```

3. The configuration will automatically:
   - Install lazy.nvim
   - Install all plugins
   - Set up LSP servers via Mason

## Requirements

- Neovim 0.11+
- Git
- A Nerd Font (for icons)
- (Optional) ripgrep, fd for improved file finding
- (Optional) A Rust compiler for blink.cmp's fuzzy matcher

## Key Mappings

- `<Space>` - Leader key
- `<Leader>f` - Fuzzy finder actions
  - `<Leader>ff` - Find files
  - `<Leader>fg` - Grep
  - `<Leader>fl` - Live grep
  - `<Leader>fb` - Buffers
- `<Leader>e` - Toggle file explorer
- `<C-h/j/k/l>` - Navigate between windows
- `<Leader>l` - LSP actions
  - `<Leader>lr` - References
  - `<Leader>ld` - Definition
  - `<Leader>ls` - Document symbols

For a complete list of keybindings, open Neovim and press `<Leader>` to see the which-key popup menu.

## Customization

Edit the files in the configuration structure to customize your setup:

- Change options in `lua/core/options/init.lua`
- Modify keymaps in `lua/core/keymaps/init.lua`
- Add plugins in `lua/plugins/init.lua`

## Acknowledgements

- [LazyVim](https://github.com/LazyVim/LazyVim) - For structural inspiration
- [NvChad](https://github.com/NvChad/NvChad) - For UI ideas
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - For LSP setup inspiration