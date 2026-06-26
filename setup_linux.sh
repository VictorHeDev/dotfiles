#!/usr/bin/env bash
# Ubuntu server setup script
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📍 Dotfiles directory: $DOTFILES_DIR"

# ===================== PACKAGE INSTALLATION =====================
echo "📦 Updating apt..."
sudo apt update

echo "📦 Installing core packages..."
sudo apt install -y \
    git \
    stow \
    zsh \
    tmux \
    tmux-plugin-manager \
    curl \
    jq \
    ripgrep \
    fd-find \
    fzf \
    zsh-autosuggestions \
    zsh-syntax-highlighting

# Packages not in standard apt repos — install via alternative methods
# git-delta
if ! command -v delta >/dev/null 2>&1; then
    echo "📦 Installing git-delta..."
    DELTA_VERSION="$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | jq -r '.tag_name')"
    curl -sL "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -o /tmp/git-delta.deb
    sudo dpkg -i /tmp/git-delta.deb
    rm /tmp/git-delta.deb
fi

# starship prompt
if ! command -v starship >/dev/null 2>&1; then
    echo "📦 Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

# zoxide
if ! command -v zoxide >/dev/null 2>&1; then
    echo "📦 Installing zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

echo "✅ Package installation complete"

# ===================== DEFAULT SHELL =====================
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

# ===================== DOTFILES =====================
echo "🔗 Setting up dotfiles with stow..."

STOW_DIR="$DOTFILES_DIR"
STOW_TARGET="$HOME"

cd "$STOW_DIR"

stow --target "$STOW_TARGET" aliases git ssh zsh tmux claude

echo "✅ Core dotfiles stowed"

echo "Linux setup complete! Please restart your shell."
