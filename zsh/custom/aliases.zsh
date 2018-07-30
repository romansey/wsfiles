if [[ $WSFILES_OS == 'osx' ]]; then
    alias ls='ls -GF'
else
    alias ls='ls --color=auto'
    alias open='xdg-open'
fi

alias l='ls -lh'
alias ll='ls -lah'

alias editws="$EDITOR $WSFILES"
alias cdws="cd $WSFILES"

alias glog="git log --all --graph"
alias gclean="git clean -xdf"