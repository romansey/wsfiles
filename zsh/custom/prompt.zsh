get_symbols() {
    local retval=$?
    [[ $retval -ne 0 ]] && echo -n " %F{$WSFILES_RED}✘%f"
    [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n " %F{$WSFILES_BRIGHT}⚙%f"
}

get_git() {
    local branch=$(git_current_branch)
    if [[ -n $branch ]]; then
        echo -n " $branch"
        echo -n "$(get_git_status)"
    fi
}

get_git_status() {
    local indexStatus=$(command git status --porcelain -b 2> /dev/null)
    local symbols=''
    echo "$indexStatus" | grep '^[^#\?]' &> /dev/null && symbols+="±"
    echo "$indexStatus" | grep '^\?' &> /dev/null && symbols+="?"
    echo "$indexStatus" | grep '^## [^ ]\+ .*ahead' &> /dev/null && symbols+="⇡"
    echo "$indexStatus" | grep '^## [^ ]\+ .*behind' &> /dev/null && symbols+="⇣"
    if [[ -n $symbols ]]; then
        echo " $symbols"
    fi
}

get_virtualenv() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo -n " 🐍 "
        if [[ $VIRTUAL_ENV:t =~ \.?(v(irtual)?)?env$ ]]; then
            echo -n "$VIRTUAL_ENV:h:t"
        else
            echo -n "$VIRTUAL_ENV:t"
        fi
    fi
}

git_current_branch() {
    local ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

build_prompt() {
    local statusSymbols=$(get_symbols)
    local statusVirtualenv=$(get_virtualenv)
    local statusGit=$(get_git)
    if [[ -n $statusVirtualenv ]] || [[ -n $statusSymbols ]]; then
        echo -n "%K{$WSFILES_GREY}%F{$WSFILES_BRIGHT}$statusVirtualenv$statusSymbols %f%k"
        echo -n "%K{$WSFILES_ORANGE}%F{$WSFILES_GREY}%f%k"
    fi
    echo -n "%K{$WSFILES_ORANGE} %F{$WSFILES_BLACK}%~%f %k"
    if [[ -n $statusGit ]]; then
        echo -n "%K{$WSFILES_BLUE}%F{$WSFILES_ORANGE}%f"
        echo -n "%F{$WSFILES_BRIGHT} $statusGit %f%k"
        echo -n "%F{$WSFILES_BLUE}%f"
    else
        echo -n "%F{$WSFILES_ORANGE}%f"
    fi
    echo -n " "
}

VIRTUAL_ENV_DISABLE_PROMPT=1
PS1='$(build_prompt)'