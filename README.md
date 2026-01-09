# Dotfiles Configuration

Personal development environment configuration for Neovim, tmux, WezTerm, and zsh.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [External Tools Installation](#external-tools-installation)
  - [Ubuntu/Debian](#ubuntudebian)
  - [macOS](#macos)
- [Installation Steps](#installation-steps)
- [Post-Installation Setup](#post-installation-setup)
- [Troubleshooting](#troubleshooting)
- [What's Included](#whats-included)

## Overview

This repository contains configuration files for:
- **Neovim** - LazyVim-based setup with LSP, autocomplete, and modern features
- **tmux** - Terminal multiplexer with vim-like keybindings
- **WezTerm** - Modern GPU-accelerated terminal emulator
- **zsh** - Shell configuration with Powerlevel10k prompt

## Prerequisites

Before installing these dotfiles, you need to install several external tools that the configurations depend on.

### Required Tools

These are **essential** for the dotfiles to work properly:
- Git
- curl/wget
- A Nerd Font (for icons)
- WezTerm (terminal emulator)
- tmux (terminal multiplexer)
- zsh (shell)
- Neovim >= 0.10

### Recommended Tools

These greatly enhance the experience:
- **fd** - Fast file finder (required by Neovim file picker)
- **ripgrep (rg)** - Fast text search (required by Neovim grep)
- **lazygit** - Terminal UI for git
- **fzf** - Fuzzy finder
- **eza** - Modern ls replacement
- **ImageMagick** - Image processing (for Neovim image support)
- **Node.js & npm** - Required for many LSP servers
- **Python 3 & pip** - Required for Python support

## External Tools Installation

### Ubuntu/Debian

```bash
# Update package lists
sudo apt update

# Install essential build tools
sudo apt install -y build-essential git curl wget unzip tar gzip

# Install core tools
sudo apt install -y tmux zsh

# Install Neovim (latest stable)
# For Ubuntu 24.04+, you can use snap:
sudo snap install nvim --classic

# Or download the latest AppImage from:
# https://github.com/neovim/neovim/releases

# Install Nerd Font (MesloLGS)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
unzip Meslo.zip
fc-cache -fv
cd ~

# Install fd (file finder)
sudo apt install -y fd-find
# Create symlink (Ubuntu calls it fdfind)
sudo ln -s $(which fdfind) /usr/local/bin/fd

# Install ripgrep
sudo apt install -y ripgrep

# Install fzf
sudo apt install -y fzf

# Install eza (modern ls)
sudo apt install -y eza

# Install ImageMagick
sudo apt install -y imagemagick

# Install Node.js and npm
sudo apt install -y nodejs npm

# Install lazygit
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install lazygit

# Install zsh plugins (via apt)
sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k

# Install WezTerm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm

# Install tmux plugin manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Python tools
pip install --upgrade pynvim

# Optional: Install additional language runtimes for Mason LSP servers
# Rust (for rust-analyzer, etc.)
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go (for gopls, etc.)
# sudo apt install -y golang-go
```

### macOS

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools
brew install git curl wget tmux zsh neovim

# Install Nerd Font
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font

# Install essential tools
brew install fd ripgrep fzf eza imagemagick node

# Install lazygit
brew install lazygit

# Install zsh plugins
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

# Install WezTerm
brew install --cask wezterm

# Install tmux plugin manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Python tools
pip3 install --upgrade pynvim

# Optional: Install additional language runtimes
# brew install go rust
```

## Installation Steps

### 1. Clone the Repository

```bash
# Clone to your home directory
cd ~
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the Installation Script

The automated script will create symlinks and backup existing configurations:

```bash
# Make the script executable
chmod +x install.sh

# Run the installation
./install.sh
```

The script will:
- Create symlinks from this repo to standard config locations
- Backup any existing files with timestamps (e.g., `.zshrc.backup.20240115_143022`)
- Create necessary directories (`~/.config/nvim`, `~/.config/wezterm`, etc.)

### 3. Manual Installation (Alternative)

If you prefer manual setup:

```bash
# Backup existing configs
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.tmux.conf ~/.tmux.conf.backup
mv ~/.wezterm.lua ~/.wezterm.lua.backup
mv ~/.zshrc ~/.zshrc.backup

# Create symlinks
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
```

## Post-Installation Setup

### 1. Configure Zsh

```bash
# Change default shell to zsh
chsh -s $(which zsh)

# Restart your terminal, then configure Powerlevel10k
p10k configure
```

Follow the interactive prompts to customize your prompt.

### 2. Configure tmux

```bash
# Start tmux
tmux

# Inside tmux, install plugins by pressing:
# <prefix> + I (that's capital I)
# Default prefix is Ctrl+b
```

Wait for plugins to install, then exit tmux with `exit` or Ctrl+d.

### 3. Configure Neovim

```bash
# Open Neovim
nvim
```

On first launch, LazyVim will:
1. Auto-install lazy.nvim (plugin manager)
2. Download and install all plugins
3. Set up LSP servers via Mason

This may take a few minutes. Once complete:

```vim
" Check health status
:checkhealth

" Open Mason to install LSP servers
:Mason
```

In Mason, navigate with `j/k` and press `i` to install language servers you need:
- **Python**: `pyright` or `pylsp`
- **JavaScript/TypeScript**: `typescript-language-server`
- **Lua**: `lua-language-server` (should auto-install)
- **JSON**: `json-lsp`
- **HTML/CSS**: `html-lsp`, `css-lsp`

### 4. Fix tmux Color Issues (if needed)

If you see warnings about true color support, add this to your shell profile:

```bash
# For zsh (already in the provided zshrc)
export TERM=xterm-256color
```

Then restart your terminal and tmux.

## Troubleshooting

### Conda Initialization Fails

**Important**: The `zsh/zshrc` file contains conda initialization code that points to a specific conda installation path. **Before using these dotfiles, verify your conda installation matches the path in the zshrc file.**

Check which conda distribution you have installed:

```bash
# Check if you have miniconda
ls ~/miniconda3/bin/conda

# Check if you have anaconda
ls ~/anaconda3/bin/conda
```

The zshrc file is currently configured for **anaconda3**. If you have **miniconda3** installed instead, you need to update the paths in `zsh/zshrc`:

```bash
# Edit the file and change all instances of 'anaconda3' to 'miniconda3'
# Lines 28-35 in zsh/zshrc

# From:
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# ...
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/anaconda3/bin:$PATH"
fi

# To:
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# ...
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/miniconda3/bin:$PATH"
fi
```

After making changes, reload your shell:

```bash
source ~/.zshrc
```

### Neovim Plugin Issues

```bash
# Reset Neovim plugins
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim - it will reinstall everything
nvim
```

### tmux Not Working Properly

```bash
# Reload tmux configuration
tmux source-file ~/.tmux.conf

# Or inside tmux, press:
# <prefix> + r
```

### Icons Not Showing

Make sure you:
1. Installed a Nerd Font (MesloLGS recommended)
2. Set WezTerm to use that font (check `wezterm/wezterm.lua`)
3. Restarted your terminal

### zsh Plugins Not Loading

```bash
# Ensure plugins are installed
ls /usr/share/zsh-autosuggestions  # Ubuntu
ls /opt/homebrew/share/zsh-autosuggestions  # macOS

# Source the config manually
source ~/.zshrc
```

### Check Health Status

```bash
# In Neovim, run:
:checkhealth

# This will show you what's missing or misconfigured
```

Common issues from health check:
- **fd not found**: Install `fd-find` and symlink to `fd`
- **node not found**: Install Node.js via apt/brew
- **lazygit not found**: Follow installation steps above
- **tmux escape-time too high**: The provided tmux.conf fixes this
- **True color not working**: Add terminal-features to tmux.conf (already included)

## What's Included

### Neovim Configuration

- **Base**: LazyVim framework
- **Theme**: Catppuccin (Latte - light mode)
- **Plugins**:
  - LSP support via mason.nvim
  - Autocompletion via blink.cmp
  - File picker via Snacks.picker
  - Git integration via gitsigns
  - Treesitter syntax highlighting
  - Rainbow indentation guides
  - Contextual function headers

**Key Bindings** (LazyVim defaults):
- Leader key: `<Space>`
- File picker: `<leader>ff`
- Grep search: `<leader>sg`
- Git UI (lazygit): `<leader>gg`
- LSP goto definition: `gd`
- LSP references: `gr`
- Toggle terminal: `<Ctrl-/>`

### tmux Configuration

**Key Bindings**:
- Prefix: `Ctrl+b` (default)
- Split horizontal: `<prefix> |`
- Split vertical: `<prefix> -`
- Navigate panes: `<prefix> h/j/k/l` (vim-style)
- Resize panes: `<prefix> H/J/K/L` (hold prefix and repeat)
- Maximize pane: `<prefix> m`
- Reload config: `<prefix> r`
- Copy mode: `<prefix> [` (use vim keys, `v` to select, `y` to yank)

**Features**:
- Seamless Neovim ↔ tmux navigation
- Session persistence (auto-saves every 15 minutes)
- True color support
- Low escape-time for better Neovim experience

### WezTerm Configuration

- **Font**: MesloLGS Nerd Font Mono, size 15
- **Theme**: Everforest Light (Gogh)
- **Tab switching**: `Alt+1-9`, `Alt+arrows`
- Auto-reloads on config changes

### zsh Configuration

- **Prompt**: Powerlevel10k
- **Plugins**:
  - zsh-autosuggestions (suggest commands from history)
  - zsh-syntax-highlighting (highlight valid commands)
- **Aliases**:
  - `ls` → `eza --icons=always`
- **History**: Shared across sessions, deduplicated
- **Arrow keys**: Search history based on current input

## Updating

```bash
# Pull latest changes
cd ~/dotfiles
git pull

# Restart your terminal or reload configs:
source ~/.zshrc                    # Reload zsh
tmux source-file ~/.tmux.conf      # Reload tmux (or <prefix>+r)
# Neovim will auto-update plugins on next launch
```

## Customization

### Adding Neovim Plugins

Create or edit files in `nvim/lua/plugins/`:

```lua
-- nvim/lua/plugins/my-custom.lua
return {
  {
    "author/plugin-name",
    lazy = false,
    config = function()
      -- plugin configuration
    end,
  },
}
```

### Modifying Keybindings

Edit `nvim/lua/config/keymaps.lua` for Neovim keymaps.

### Changing Theme

Edit `nvim/lua/plugins/myPlugins.lua` and change the colorscheme.

## Contributing

This is a personal dotfiles repo, but feel free to fork and adapt for your own use!

## License

MIT - Feel free to use and modify as needed.
