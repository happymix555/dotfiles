# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS development environment configuration. It contains configuration files for:
- **Neovim** (LazyVim-based setup)
- **tmux** (terminal multiplexer)
- **WezTerm** (terminal emulator)
- **zsh** (shell configuration)

## Repository Structure

```
.
├── nvim/           # Neovim configuration (LazyVim-based)
│   ├── init.lua    # Entry point, bootstraps lazy.nvim
│   ├── lua/
│   │   ├── config/ # LazyVim core config (autocmds, keymaps, options, lazy setup)
│   │   └── plugins/ # Custom plugin configurations
│   ├── lazy-lock.json # Plugin version lock file
│   └── stylua.toml    # Lua formatter config (2 spaces, 120 columns)
├── tmux/
│   └── tmux.conf   # tmux configuration
├── wezterm/
│   └── wezterm.lua # WezTerm terminal emulator config
└── zsh/
    └── zshrc       # zsh shell configuration
```

## Neovim Configuration Architecture

This Neovim setup is based on [LazyVim](https://github.com/LazyVim/LazyVim), a Neovim configuration framework built on lazy.nvim.

### Plugin Management

- **Package Manager**: lazy.nvim (auto-installed if missing)
- **Entry Point**: `nvim/init.lua` → `require("config.lazy")`
- **Plugin Loading**: All custom plugins in `lua/plugins/*.lua` are automatically imported
- **Lock File**: `lazy-lock.json` pins plugin versions (similar to package-lock.json)
- **Update Checking**: Enabled by default but notifications are disabled

### Custom Plugins Configuration

The main custom configuration is in `nvim/lua/plugins/myPlugins.lua`:

1. **Catppuccin Theme** (latte flavor for light mode)
   - Set as default colorscheme
   - Configured with italic comments and conditionals
   - Integrations enabled for cmp, gitsigns, treesitter, telescope, mason, which-key

2. **Rainbow Indentation** (`indent-blankline.nvim`)
   - Custom rainbow colors optimized for Catppuccin latte theme
   - Shows scope start but not end
   - Disabled for special buffers (help, dashboard, neo-tree, etc.)

3. **Treesitter Context** (`nvim-treesitter-context`)
   - Shows function/class context at top of buffer
   - Max 3 lines, cursor-based mode
   - Toggle with `<leader>ut`

4. **Enhanced Lualine**
   - Shows relative file path with modified indicator (●)
   - Readonly and unnamed file indicators

### LazyVim Configuration Pattern

- **Options**: `lua/config/options.lua` (currently uses LazyVim defaults)
- **Keymaps**: `lua/config/keymaps.lua` (currently uses LazyVim defaults)
- **Autocmds**: `lua/config/autocmds.lua` (auto-loaded)
- **Plugin Defaults**: Custom plugins are NOT lazy-loaded by default (`lazy = false`)

### Code Formatting

- **Tool**: stylua
- **Config**: `nvim/stylua.toml`
- **Style**: 2-space indentation, 120 character line width

## tmux Configuration

Key customizations in `tmux/tmux.conf`:

- **Split Keybindings**: `|` for horizontal, `-` for vertical
- **Reload Config**: `<prefix> + r`
- **Pane Resizing**: Vim-style `hjkl` with `<prefix>` (repeatable with `-r`)
- **Maximize/Minimize Pane**: `<prefix> + m`
- **Copy Mode**: Vim-style with `v` to select, `y` to yank
- **Navigation**: vim-tmux-navigator plugin for seamless Neovim ↔ tmux pane navigation
- **Session Persistence**: tmux-continuum (auto-saves every 15 minutes, auto-restore enabled)

### tmux Plugin Manager

Plugins are managed via TPM (must be installed separately):
- `christoomey/vim-tmux-navigator`
- `tmux-plugins/tmux-continuum`

## WezTerm Configuration

Terminal emulator settings in `wezterm/wezterm.lua`:

- **Font**: MesloLGS Nerd Font Mono, size 17
- **Theme**: Everforest Light (Gogh)
- **Tab Bar**: Disabled
- **Tab Switching**: Alt + number (1-9), Alt + arrows
- **Platform Note**: Wayland support disabled (macOS config has blur commented out)

## zsh Configuration

Shell setup in `zsh/zshrc`:

- **Prompt**: Powerlevel10k (installed via Homebrew)
- **History**: 1000 saved, shared across sessions, deduplicates
- **Arrow Key Search**: Up/down arrows search history based on current input
- **Plugins**: zsh-autosuggestions, zsh-syntax-highlighting (via Homebrew)
- **Environment**: conda (miniconda3), VS Code CLI, Antigravity
- **Aliases**: `ls` aliased to `eza --icons=always`

## Modifying Configurations

### Adding Neovim Plugins

1. Create or edit a file in `nvim/lua/plugins/`
2. Return a table with plugin specs (LazyVim format)
3. Plugins auto-load on Neovim restart
4. Lock versions by committing `lazy-lock.json`

### Formatting Lua Code

Run stylua with the repo's config:
```bash
stylua --config-path nvim/stylua.toml nvim/lua/
```

### Testing tmux Changes

Reload tmux config:
```bash
# Inside tmux
<prefix> + r

# Or from command line
tmux source-file ~/.tmux.conf
```

### Testing WezTerm Changes

WezTerm auto-reloads on config file save. Check for errors in console output.

## Installation

### Automated Installation

Run the installation script to automatically symlink all dotfiles:

```bash
# Make the script executable (first time only)
chmod +x install.sh

# Run the installation script
./install.sh
```

The script will:
- Create symlinks from this repo to standard config locations
- Backup any existing files with timestamp (e.g., `.zshrc.backup.20240115_143022`)
- Create necessary directories (`~/.config/nvim`, `~/.config/wezterm`, etc.)
- Provide next steps and dependency installation instructions

### Manual Installation

Alternatively, symlink files manually:

```bash
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/wezterm/wezterm.lua" ~/.wezterm.lua
ln -s "$(pwd)/zsh/zshrc" ~/.zshrc
```

### Dependencies

**Required Homebrew packages:**
```bash
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting eza
```

**tmux Plugin Manager (TPM):**
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: <prefix> + I (capital i) to install plugins
```

**Fonts:**
- Install MesloLGS Nerd Font for proper icon rendering

**First-time setup:**
1. Restart terminal or run `source ~/.zshrc`
2. Open Neovim - LazyVim will auto-install lazy.nvim and all plugins
3. Install tmux plugins: `<prefix> + I` in tmux
4. Configure Powerlevel10k: run `p10k configure` if needed
