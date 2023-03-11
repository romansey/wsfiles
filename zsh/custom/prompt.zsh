# Ouputs general status symbols, separted by space. Currently ✘ for
# non-zero exit code of last command and ⚙ for running background tasks.
prompt_symbols() {
    local exit_code=$1
    local symbols=()
    [[ $exit_code -ne 0 ]] && symbols+="%F{$WSFILES_RED}✘%f"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%F{$WSFILES_BRIGHT}⚙%f"
    echo "$symbols"
}

# Outputs the current Git branch and status icons. Empty, if no Git repo.
prompt_git() {
    local branch=$(git_current_branch)
    local index_status=$(git_status)
    if [[ -n $branch ]]; then
        echo -n " $branch"
        if [[ -n $index_status ]]; then
            echo -n " $(git_status)"
        fi
    fi
}

# Prints the short name of an active Python virtualenv if any.
prompt_virtualenv() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo -n '🐍 '
        if [[ $VIRTUAL_ENV:t =~ \.?(v(irtual)?)?env$ ]]; then
            echo -n "$VIRTUAL_ENV:h:t"
        else
            echo -n "$VIRTUAL_ENV:t"
        fi
    fi
}

# Constructs the prompt.
build_prompt() {
    local exit_code=$?

    # Set prompt segments and their desired fg and bg colors.
    # Texts will be trimmed and segments skipped, if text is empty.
    local segment_texts=("$WSFILES_MACHINE $(prompt_virtualenv) $(prompt_symbols $exit_code)" '%~' "$(prompt_git)")
    local segment_colors_fg=("$WSFILES_BRIGHT" "$WSFILES_DARK" "$WSFILES_BRIGHT")
    local segment_colors_bg=("$WSFILES_GREY" "$WSFILES_ORANGE" "$WSFILES_BLUE")

    # Output segments
    local last_bg=''
    for i in $(seq 1 "${#segment_texts[@]}"); do
        local current_text=$(echo "${segment_texts[$i]}" | awk '{$1=$1;print}')
        local current_fg=${segment_colors_fg[$i]}
        local current_bg=${segment_colors_bg[$i]}
        # Skip empty segments
        [[ -z $current_text ]] && continue
        if [[ -n $last_bg ]]; then
            echo -n "%K{$current_bg}%F{$last_bg}%f%k"
        fi
        echo -n "%K{$current_bg}%F{$current_fg} $current_text %f%k"
        last_bg=$current_bg
    done
    if [[ -n $last_bg ]]; then
        echo -n "%F{$last_bg}%f"
    fi
    echo -n " "
}

VIRTUAL_ENV_DISABLE_PROMPT=1
PS1='$(build_prompt)'
