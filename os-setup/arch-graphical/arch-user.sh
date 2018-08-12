#!/bin/bash
set -e

# Install aurman
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --skippgpcheck
cd ..
rm -rf yay

# Install AUR packages
yay -Sy --noconfirm \
    kubectl-bin minikube-bin visual-studio-code-bin nvm google-chrome \

# Setup ZSH
chsh -s /bin/zsh
cat >~/.zshrc <<EOF
# Machine-specific settings
export EDITOR=vim

# Assemble path
export PATH="$PATH"

# ZSH configuration
WSFILES=~/workstation-files
source "$WSFILES/zsh/init.zsh"
EOF