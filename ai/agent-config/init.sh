#!/bin/bash
set -e

main() {
  cd "$(dirname "$0")"

  mkdir -p "$HOME/.claude" "$HOME/.config/opencode"

  linkIfNotExists "$HOME/.claude" "CLAUDE.md" "./AGENTS.md"
  linkIfNotExists "$HOME/.claude" "skills" "./claude/skills"

  linkIfNotExists "$HOME/.config/opencode" "AGENTS.md" "./AGENTS.md"
  linkIfNotExists "$HOME/.config/opencode" "agents" "./opencode/agents"
  linkIfNotExists "$HOME/.config/opencode" "commands" "./opencode/commands"
}

linkIfNotExists() {
    local linkBase="$1"
    local linkName="$2"
    local targetLocation="$3"
    local linkLocation="$1/$2"

    if [ -e "$linkLocation" ]; then
        echo "Skipping symlink for '$linkLocation', already exists."
    else
        local linkTarget=$(printRelativePath "$targetLocation" "$linkBase")
        ln -s "$linkTarget" "$linkLocation"
        echo "Symlinked '$linkLocation'."
    fi
}

printRelativePath() {
    local targetLocation="$1"
    local base="$2"
    python3 -c "import os.path; print(os.path.relpath('$targetLocation', '$base'))"
}

main
