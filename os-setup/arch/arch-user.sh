#!/bin/bash
set -e
cd "$(dirname "$0")/../../"

# Setup ZSH
chsh -s /bin/zsh
cat >~/.zshrc <<EOF
# Machine-specific settings
export EDITOR=vim

# Assemble path
export PATH="\$PATH"

# ZSH configuration
WSFILES=$(pwd)
source "\$WSFILES/zsh/init.zsh"

# Additional initialization
source <(helm completion zsh)
EOF

# Install aurman
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --skippgpcheck
cd ..
rm -rf yay

# Install AUR packages
yay -Sy --noconfirm \
    kubectl-bin minikube-bin kubernetes-helm \
    visual-studio-code-bin nvm google-chrome