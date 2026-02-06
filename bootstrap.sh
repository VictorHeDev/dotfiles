#!/bin/bash
##########################
# .make.sh
# This script creates symlinks from the dotfiles directory to any desired dotfiles in ~/dotfiles
# remember! run "chmod +x bootstrap.sh" to give this file permissions
##########################

# support different flags
if [[ "$1" == "--dry-run" ]]; then
	STOW_FLAGS='-nv'
	echo "⚠️ Running in dry-run mode"

else
	STOW_FLAGS='-v'
fi

# Check OS and maybe install stow if not present
OS="$(uname -s)"
#
# Exit on error
set -e
cd "$(dirname "$0")" || exit 1
echo "📦 Bootstrapping dotfiles using GNU Stow for OS: $OS"

########################## Vars
IS_MAC=false
IS_LINUX=false
##########################

case "$OS" in
Darwin) IS_MAC=true ;;
Linux) IS_LINUX=true ;;
*)
	echo "Unsupported OS"
	exit 1
	;;
esac

# Set stow package list depending on OS
if $IS_MAC; then
	PACKAGES+=(
		zsh
		hammerspoon
	)
elif $IS_LINUX; then
	PACKAGES+=(
		bash
		zsh
	)
fi

# install stow if missing
if ! command -v stow >/dev/null 2>&1; then
	if $IS_MAC; then
		echo "🔧 Installing stow via Homebrew..."
		brew install stow
	elif $IS_LINUX; then
		echo "🔧 Installing stow via apt..."
		sudo apt install -y stow
	fi
fi

# Install zsh plugins, tmux plugin manager, and CLI tools
echo "🔌 Installing zsh plugins, tmux plugin manager, and CLI tools..."
if $IS_MAC; then
	brew install zsh-autosuggestions zsh-syntax-highlighting tmux-plugin-manager bat zoxide
elif $IS_LINUX; then
	sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting tmux-plugin-manager bat zoxide
fi

# Loop and unpack for each
for pkg in "${PACKAGES[@]}"; do
	echo "🔗 Stowing $pkg"
	stow $STOW_FLAGS "$pkg"
done

echo "✅ Dotfiles setup complete."
