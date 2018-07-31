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

alias gco='git checkout'
alias gcot='git checkout -t'
alias gcob='git checkout -b'
alias gf='git fetch --all --prune'
alias gbd='git branch -d'
alias gpd='git push -d'
alias gclean='git clean -df'
alias gclear='git reset --hard HEAD && git clean -xdf'
alias glog='git log --all --graph'
alias gd='git diff'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gcam='git commit -am'
alias gcm='git commit -m'