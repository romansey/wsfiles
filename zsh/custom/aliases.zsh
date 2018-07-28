if [[ $DOTFILES_OS == 'osx' ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
    alias open='xdg-open'
fi

alias l='ls -lh'
alias ll='ls -lah'