#!/usr/bin/env bash
# Set up zsh + Doom Emacs on Ubuntu 24.04 (GNOME Terminal).
# Safe to run again: finished steps are skipped, and any existing config file
# is moved to <file>.backup-<date> before being replaced by a link.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

case "$DOTFILES" in
    */.claude/worktrees/*)
        echo "This copy is a temporary worktree; links into it would break later."
        echo "Run install.sh from the main checkout (e.g. ~/repos/dotfiles) instead."
        exit 1 ;;
esac

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
note() { printf '    %s\n' "$*"; }

# ── 1. Packages ───────────────────────────────────────────────────────────────
APT_PACKAGES=(
    # shell
    zsh zsh-autosuggestions zsh-syntax-highlighting
    fzf zoxide eza bat fd-find ripgrep
    # helpers used below
    git curl unzip xz-utils fontconfig
    # Emacs (pgtk = native Wayland build) + what Doom's vterm needs to compile
    emacs-pgtk cmake libtool-bin libvterm-dev
)
step "Installing apt packages (asks for your password)"
sudo apt-get update
sudo apt-get install -y "${APT_PACKAGES[@]}"

# ── 2. Starship prompt (not in Ubuntu 24.04's apt) ───────────────────────────
mkdir -p "$HOME/.local/bin"
if command -v starship >/dev/null || [[ -x "$HOME/.local/bin/starship" ]]; then
    step "Starship already installed"
else
    step "Installing starship into ~/.local/bin"
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
fi

# ── 3. Nerd Font (icons in the prompt and in eza) ─────────────────────────────
FONT_NAME="JetBrainsMono Nerd Font Mono"
if fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    step "JetBrainsMono Nerd Font already installed"
else
    step "Installing JetBrainsMono Nerd Font into ~/.local/share/fonts"
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/JetBrainsMono.tar.xz" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    mkdir -p "$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
    tar -xJf "$tmp/JetBrainsMono.tar.xz" -C "$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
    rm -rf "$tmp"
    fc-cache -f >/dev/null
fi

# ── 4. GNOME Terminal: use that font ──────────────────────────────────────────
if profile="$(gsettings get org.gnome.Terminal.ProfilesList default 2>/dev/null)"; then
    step "Setting GNOME Terminal font to '$FONT_NAME 13'"
    profile="${profile//\'/}"
    schema="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/"
    gsettings set "$schema" use-system-font false
    gsettings set "$schema" font "$FONT_NAME 13"
else
    step "GNOME Terminal not found, skipping font setting"
fi

# ── 5. Link config files ──────────────────────────────────────────────────────
link() {
    local src="$DOTFILES/$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        note "ok      $dst"
        return
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        local backup="$dst.backup-$(date +%Y%m%d-%H%M%S)"
        mv "$dst" "$backup"
        note "backup  $dst -> $backup"
    fi
    ln -s "$src" "$dst"
    note "linked  $dst -> $src"
}
step "Linking config files"
link zsh/zshrc              "$HOME/.zshrc"
link starship/starship.toml "$HOME/.config/starship.toml"

# ── 6. Make zsh the login shell ───────────────────────────────────────────────
ZSH_PATH="$(command -v zsh)"
if [[ "$(getent passwd "$USER" | cut -d: -f7)" == "$ZSH_PATH" ]]; then
    step "zsh is already your login shell"
else
    step "Making zsh your login shell (asks for your password)"
    chsh -s "$ZSH_PATH"
    note "Log out and back in for this to take effect."
fi

# ── 7. Doom Emacs ─────────────────────────────────────────────────────────────
if [[ -d "$HOME/.config/emacs" ]]; then
    step "Doom Emacs already present in ~/.config/emacs"
else
    step "Installing Doom Emacs into ~/.config/emacs (takes a few minutes)"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
    "$HOME/.config/emacs/bin/doom" install
fi

step "Done."
note "Open a new terminal (or log out/in once) to start using zsh."
note "Then, from zsh, run:  doom env   so Emacs sees the same PATH as your shell."
