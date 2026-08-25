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
    zsh-syntax-highlighting \
    build-essential \
    golang-go \
    bat \
    gh

# Packages not in standard apt repos — install via alternative methods
# neovim (apt's version lags far behind upstream; this config needs a recent
# release for native LSP config and treesitter's main branch)
if [[ "$(readlink -f "$(command -v nvim 2>/dev/null)" 2>/dev/null)" != "$HOME/.local/share/nvim-linux-x86_64/bin/nvim" ]]; then
    echo "📦 Installing neovim..."
    curl -sSL -o /tmp/nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    rm -rf ~/.local/share/nvim-linux-x86_64
    mkdir -p ~/.local/share
    tar xzf /tmp/nvim-linux-x86_64.tar.gz -C ~/.local/share/
    rm /tmp/nvim-linux-x86_64.tar.gz
    mkdir -p ~/.local/bin
    ln -sf ~/.local/share/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
fi

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

# lazygit
if ! command -v lazygit >/dev/null 2>&1; then
    echo "📦 Installing lazygit..."
    LAZYGIT_VERSION="$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r '.tag_name' | tr -d v)"
    curl -sL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_x86_64.tar.gz" -o /tmp/lazygit.tar.gz
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    mkdir -p ~/.local/bin
    mv /tmp/lazygit ~/.local/bin/lazygit
    rm /tmp/lazygit.tar.gz
fi

# herdr
if ! command -v herdr >/dev/null 2>&1; then
    echo "📦 Installing herdr..."
    curl -fsSL https://herdr.dev/install.sh | sh
fi

# tree-sitter-cli (needed by nvim-treesitter to compile parsers; not in apt)
if ! command -v tree-sitter >/dev/null 2>&1; then
    echo "📦 Installing tree-sitter-cli..."
    curl -sL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz -o /tmp/tree-sitter.gz
    gunzip -f /tmp/tree-sitter.gz
    mkdir -p ~/.local/bin
    mv /tmp/tree-sitter ~/.local/bin/tree-sitter
    chmod +x ~/.local/bin/tree-sitter
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

stow --target "$STOW_TARGET" aliases git ssh zsh tmux claude nvim herdr lazygit

echo "✅ Core dotfiles stowed"

echo "Linux setup complete! Please restart your shell."
