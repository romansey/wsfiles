# Outputs Git status symbols for the current repo, if any.
# ± = Modified files
# ? = Untracked files
# ⇡ = Local branch ahead of remote
# ⇣ = Local branch behind of remote
git_status() {
    local index_status=$(command git status --porcelain -b 2> /dev/null)
    local symbols=''
    echo "$index_status" | grep '^[^#\?]' &> /dev/null && symbols+="±"
    echo "$index_status" | grep '^\?' &> /dev/null && symbols+="?"
    echo "$index_status" | grep '^## [^ ]\+ .*ahead' &> /dev/null && symbols+="⇡"
    echo "$index_status" | grep '^## [^ ]\+ .*behind' &> /dev/null && symbols+="⇣"
    if [[ -n $symbols ]]; then
        echo "$symbols"
    fi
}

# Outputs the current Git branch or commit hash if any.
git_current_branch() {
    local ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}