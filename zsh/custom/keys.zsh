# Use emacs defaults
bindkey -e

# Cursor navigation
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
if [[ $WSFILES_OS == 'osx' ]]; then
    bindkey '^[^[[C' forward-word
    bindkey '^[^[[D' backward-word
else
    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word
fi