#!/usr/bin/env bash
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📍 Dotfiles directory: $DOTFILES_DIR"

# ===================== Brewfile Installation =====================
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if homebrew is available
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "📦 Installing core Brewfile..."
brew bundle --file "$DOTFILES_DIR/brew/Brewfile.core"

# Optional Kubernetes tools
if [[ "${INSTALL_K8S:-false}" == "true" ]]; then
  echo "☸️  Installing Kubernetes tools..."
  brew bundle --file "$DOTFILES_DIR/brew/Brewfile.k8s"
fi

echo "✅ Homebrew setup complete"

# check if /opt/homebrew/share exists and changes ownership recursively to the current user
# removes groups/other write permissions to the top-level dir and Zsh plugin dirs
echo "🔐 Fixing Zsh compinit permissions..."

BREW_ZSH_DIR="/opt/homebrew/share"

if [[ -d "$BREW_ZSH_DIR" ]]; then
  echo "💡 Ensuring $BREW_ZSH_DIR is owned by current user..."
  sudo chown -R $(whoami) "$BREW_ZSH_DIR"

  echo "💡 Removing group/other write permissions..."
  chmod go-w "$BREW_ZSH_DIR"
  chmod -R go-w "$BREW_ZSH_DIR/zsh" 2>/dev/null || true

  echo "✅ Zsh compinit directories fixed."
else
  echo "⚠️ $BREW_ZSH_DIR does not exist. Skipping compinit fix."
fi

# ======================== FINDER ========================
# show full path
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder

# show folders before files
# defaults write com.apple.finder _FXSortFoldersFirst -bool true; killall Finder
echo "✅ Finder setup complete"

# ===================== APP MANAGEMENT =====================
# Show only active apps on the Dock
# defaults write com.apple.dock static-only -bool true; killall Dock

# Single App Mode
# defaults write com.apple.dock single-app -bool true; killall Dock

# Always show scroll bars
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"; killall Finder
echo "✅ App Management setup complete"

# ===================== KEYBOARD =====================
# Enable Key Repeat Globally
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# defaults write -g ApplePressAndHoldEnabled -bool false

# Enable Key Repeat in Terminal
# defaults write -g KeyRepeat -int 1
# defaults write -g InitialKeyRepeat -int 12
echo "✅ Keyboard setup complete"

# ===================== SPACES =====================
# disable rearrangement
# defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock

# enable rearrangement
# defaults write com.apple.dock "mru-spaces" -bool "true" && killall Dock
echo "✅ Spaces setup complete"

# ===================== DOTFILES =====================
echo "🔗 Setting up dotfiles with stow..."

STOW_DIR="$DOTFILES_DIR"
STOW_TARGET="$HOME"

cd "$STOW_DIR"

stow --target "$STOW_TARGET" aliases git ssh zsh ghostty hammerspoon tmux claude

echo "✅ Core dotfiles stowed"

# ===================== TPM =====================
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "📦 Installing TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "✅ TPM installed"
fi

echo "Mac Setup complete! 🎉"
