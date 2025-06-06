# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Hyprland window manager configuration repository with a modular structure that separates default configurations from user customizations.

## Configuration Structure

The configuration follows a two-layer approach:
- `hyprland/` - Default configurations (do not modify directly)
- `custom/` - User customizations that override defaults

Main entry point: `hyprland.conf` sources all configuration files in order.

## Key Configuration Files

- `hyprland.conf` - Main config that sources other files and sets NVIDIA variables
- `hypridle.conf` - Idle management (screen timeout, lock, suspend)
- `hyprlock.conf` - Lock screen configuration (Rose Pine theme)

Modular configs (in both `hyprland/` and `custom/`):
- `env.conf` - Environment variables
- `execs.conf` - Auto-start applications
- `general.conf` - Input, appearance, animations, plugin settings
- `keybinds.conf` - Key bindings
- `rules.conf` - Window and layer rules
- `colors.conf` - Rose Pine color scheme

## Common Development Tasks

### Building Plugins

**Hyprspace plugin:**
```bash
cd plugins/Hyprspace
make
# or with hyprpm headers:
make withhyprpmheaders
```

**hyprfocus plugin:**
```bash
cd plugins/hyprfocus
mkdir build && cd build
cmake ..
make
```

### Reloading Configuration

- Full reload with AGS restart: `Ctrl+Super+Alt+R`
- Reload plugins: `hyprpm reload`
- Manual reload: `hyprctl reload`

## Important Notes

- This config uses AGS (Aylur's GTK Shell) for UI components - started via `/home/faiyt/.config/ags/dev.sh`
- Monitor configuration is set in `hyprland.conf` (bottom) and dynamically adjusted in `execs.conf`
- The configuration uses Rose Pine theme throughout
- Shader effects are applied via `hyprland/general.conf`
- Clipboard history is managed by cliphist
- Screenshots are handled via AGS launcher (Super+Shift+S)