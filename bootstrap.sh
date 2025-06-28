#!/bin/bash
##########################
# .make.sh
# This script creates symlinks from the dotfiles directory to any desired dotfiles in ~/dotfiles
# remember! run "chmod +x bootstrap.sh" to give this file permissions
##########################

# Exit on error
set -e
cd "$(dirname "$0")"
echo "📦 Bootstrapping dotfiles using GNU Stow..."

########################## VARIABLES
PACKAGES=(
	aliases
	bash
	ghostty
	tmux
	nvim
	# zsh
)
##########################

# Loop and unpack for each
for pkg in "${PACKAGES[@]}"; do
	echo "Stowing $pkg"
	stow -v "$pkg"
done

echo "✅ Dotfiles setup complete."
