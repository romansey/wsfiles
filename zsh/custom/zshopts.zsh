# General
setopt autocd notify
unsetopt beep
setopt prompt_subst

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt hist_expire_dups_first
setopt hist_ignore_dups

# Completion
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path '~/.zsh_cache'
zstyle ':completion:*:*:*:users' ignored-patterns \
zstyle '*' single-ignored show