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

# Performs a fetch for all Git repo directories in the current dir
git_fetch_all() {
    for dir in ./*/; do
        if [[ -d "$dir/.git" ]]; then
            echo "Fetching repo at $dir ..."
            (cd "$dir" && git fetch --all --prune)
        fi
    done
}

# Outputs the Git status for all subdirectories
git_scan_directory() {
    for dir in ./*/; do
        local branch="$(cd "$dir" && git_current_branch)"
        local statusSymbols=""
        if [[ -n $branch ]]; then
            statusSymbols="$(cd "$dir" && git_status)"
            if [[ -n $statusSymbols ]]; then
                if [[ $statusSymbols =~ .*[±?].* ]]; then
                    echo "\033[0;31m$dir [$branch $statusSymbols]\033[0m"
                else
                    echo "\033[0;33m$dir [$branch $statusSymbols]\033[0m"
                fi
            else
                echo "\033[0;32m$dir [$branch ✔]\033[0m"
            fi
        else
            echo "$dir [no git repo]"
        fi
    done
}