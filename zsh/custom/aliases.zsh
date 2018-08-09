if [[ $WSFILES_OS == 'osx' ]]; then
    alias ls='ls -GF'
else
    alias ls='ls --color=auto'
    alias open='xdg-open'
fi

alias l='ls -lh'
alias ll='ls -lah'

alias wscd="cd $WSFILES"
alias wsrl='source ~/.zshrc'

alias pyenv='source ./env/bin/activate'

alias d='docker'
alias dco='docker-compose'

alias k='kubectl'
alias ka='kubectl apply'
alias kc='kubectl create'
alias ke='kubectl edit'
alias kd='kubectl delete'
alias kg='kubectl get'
alias kgd='kubectl get deploy'
alias kgs='kubectl get services'
alias kgp='kubectl get pods'
alias kgn='kubectl get nodes'
alias kci='kubectl cluster-info'

alias g='git'
alias gco='git checkout'
alias gcot='git checkout -t'
alias gcob='git checkout -b'
alias gf='git fetch --all --prune'
alias gfa='git_fetch_all && git_scan_directory'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gclean='git clean -df'
alias gclear='git reset --hard HEAD && git clean -xdf'
alias grh='git reset --hard HEAD'
alias glog='git log --all --graph'
alias gd='git diff'
alias gs='git status'
alias gscan='git_scan_directory'
alias ga='git add'
alias gaa='git add -A'
alias gcam='git commit -am'
alias gcm='git commit -m'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'