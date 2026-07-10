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

# tree-sitter CLI - required by nvim-treesitter (main branch) to build parsers.
# Not in apt repos, so install the official release binary into ~/.local/bin
# (on PATH via zsh/.zshrc). cargo is the last-resort fallback.
if ! command -v tree-sitter >/dev/null 2>&1; then
    echo "📦 Installing tree-sitter-cli..."
    case "$(uname -m)" in
        x86_64|amd64)  TS_ARCH="x64" ;;
        aarch64|arm64) TS_ARCH="arm64" ;;
        *)             TS_ARCH="" ;;
    esac
    TS_VERSION="$(curl -fsSL https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | jq -r '.tag_name' 2>/dev/null || true)"
    if [[ -n "$TS_ARCH" && -n "$TS_VERSION" && "$TS_VERSION" != "null" ]]; then
        mkdir -p "$HOME/.local/bin"
        curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/download/${TS_VERSION}/tree-sitter-linux-${TS_ARCH}.gz" -o /tmp/tree-sitter.gz
        gunzip -f /tmp/tree-sitter.gz
        install -m755 /tmp/tree-sitter "$HOME/.local/bin/tree-sitter"
        rm -f /tmp/tree-sitter
    elif command -v cargo >/dev/null 2>&1; then
        cargo install tree-sitter-cli
    else
        echo "⚠️  Could not resolve tree-sitter release (arch/network?) and no cargo; skipping (nvim-treesitter can't build parsers until this is installed)."
    fi
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
