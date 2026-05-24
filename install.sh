#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# .zshrc
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

# Ghostty
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# Ghostty OS-specific config (font-family)
case "$(uname -s)" in
    Darwin) ln -sf "$DOTFILES/ghostty/config.mac"   "$HOME/.config/ghostty/config.local" ;;
    Linux)  ln -sf "$DOTFILES/ghostty/config.linux" "$HOME/.config/ghostty/config.local" ;;
    *)      echo "[install.sh] WARNING: unknown OS, skipping ghostty config.local" ;;
esac

# Starship
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# Zed text editor
mkdir -p "$HOME/.config/zed"
ln -sf "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES/zed/keymap.json" "$HOME/.config/zed/keymap.json"

echo "Dotfiles linked."
