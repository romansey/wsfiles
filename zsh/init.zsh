export DOTFILES="$(dirname "$0")"

# Custom settings
source "$DOTFILES/custom/checks.zsh"
source "$DOTFILES/custom/colors.zsh"
source "$DOTFILES/custom/zshopts.zsh"
source "$DOTFILES/custom/exports.zsh"
source "$DOTFILES/custom/aliases.zsh"
source "$DOTFILES/custom/prompt.zsh"

# Third-party plugins
source "$DOTFILES/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"