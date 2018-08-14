#!/bin/bash
set -e
WSFILES="$(dirname "$0")/../../"

# Setup ZSH
chsh -s /bin/zsh
cat >~/.zshrc <<EOF
# Machine-specific settings
export EDITOR=vim

# Assemble path
export PATH="\$PATH"

# ZSH configuration
WSFILES=\$WSFILES
source "\$WSFILES/zsh/init.zsh"
EOF

# Install aurman
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --skippgpcheck
cd ..
rm -rf yay

# Install AUR packages
yay -Sy --noconfirm \
    kubectl-bin minikube-bin visual-studio-code-bin nvm google-chrome