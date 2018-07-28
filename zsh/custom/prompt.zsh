get_symbols() {
    local retval=$?
    [[ $retval -ne 0 ]] && echo -n " %F{red}✘%f"
    [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n " %F{black}⚙%f"
}

get_git() {
    local branch=$(git_current_branch)
    if [[ -n $branch ]]; then
        echo -n "  $branch"
        echo -n "$(get_git_status)"
        echo -n " "
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
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

VIRTUAL_ENV_DISABLE_PROMPT=1
PS1='%K{red}%F{white}$(get_virtualenv) %f%K{yellow}%F{red}%f$(get_symbols) %F{black}%~%f %k%K{blue}%F{yellow}%f%F{black}$(get_git)%f%k%F{blue}%f '