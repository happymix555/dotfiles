#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect OS
case "$(uname -s)" in
    Darwin)
        IS_MACOS=true
        IS_LINUX=false
        OS_NAME="macOS"
        ;;
    Linux)
        IS_MACOS=false
        IS_LINUX=true
        OS_NAME="Linux"
        ;;
    *)
        echo -e "${RED}Unsupported OS${NC}"
        exit 1
        ;;
esac

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Installing dotfiles from: ${DOTFILES_DIR}${NC}"
echo -e "${BLUE}Detected OS: ${OS_NAME}${NC}\n"

# Function to create backup of existing file/directory
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}  Backing up existing $target to $backup${NC}"
        mv "$target" "$backup"
    elif [ -L "$target" ]; then
        echo -e "${YELLOW}  Removing existing symlink: $target${NC}"
        rm "$target"
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"

    echo -e "${GREEN}Installing $description${NC}"

    # Create parent directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo "  Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Backup existing file/directory if it exists
    backup_if_exists "$target"

    # Create symlink
    echo "  Linking: $target -> $source"
    ln -s "$source" "$target"
    echo ""
}

# Install Neovim config
create_symlink \
    "$DOTFILES_DIR/nvim" \
    "$HOME/.config/nvim" \
    "Neovim configuration"

# Install tmux config
create_symlink \
    "$DOTFILES_DIR/tmux/tmux.conf" \
    "$HOME/.tmux.conf" \
    "tmux configuration"

# Install WezTerm config (different location on Linux vs macOS)
if [ "$IS_MACOS" = true ]; then
    create_symlink \
        "$DOTFILES_DIR/wezterm/wezterm.lua" \
        "$HOME/.config/wezterm/wezterm.lua" \
        "WezTerm configuration"
else
    create_symlink \
        "$DOTFILES_DIR/wezterm/wezterm.lua" \
        "$HOME/.wezterm.lua" \
        "WezTerm configuration"
fi

# Install zsh config
create_symlink \
    "$DOTFILES_DIR/zsh/zshrc" \
    "$HOME/.zshrc" \
    "zsh configuration"

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Dotfiles installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim - LazyVim will auto-install plugins"
echo "  3. Install tmux plugins: <prefix> + I (capital i) in tmux"
echo ""

if [ "$IS_MACOS" = true ]; then
    echo "Dependencies to install (macOS with Homebrew):"
    echo "  brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting eza"
    echo ""
    echo "  Fonts: Install MesloLGS Nerd Font from:"
    echo "    https://github.com/romkatv/powerlevel10k#fonts"
else
    echo "Dependencies to install (Linux):"
    echo "  # Powerlevel10k"
    echo "  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
    echo ""
    echo "  # zsh plugins (Debian/Ubuntu)"
    echo "  sudo apt install zsh-autosuggestions zsh-syntax-highlighting"
    echo ""
    echo "  # eza (better ls) - check your distro's package manager or use cargo"
    echo "  sudo apt install eza  # or: cargo install eza"
    echo ""
    echo "  # Fonts: Install MesloLGS Nerd Font"
    echo "  # Download from: https://github.com/romkatv/powerlevel10k#fonts"
fi

echo ""
echo "  tmux Plugin Manager (TPM):"
echo "    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
