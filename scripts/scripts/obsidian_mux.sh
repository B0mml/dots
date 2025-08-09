#!/usr/bin/env bash

VAULT_DIR="$HOME/obsidian/Vault"

# Check if vault directory exists
if [[ ! -d $VAULT_DIR ]]; then
    echo "Vault directory not found: $VAULT_DIR"
    exit 1
fi

# Use fzf to select a markdown file, excluding templates
selected=$(find "$VAULT_DIR" -name "*.md" -type f -not -path "*/templates/*" | fzf)

# Exit if nothing selected
if [[ -z $selected ]]; then
    exit 0
fi

# Extract filename without extension and path for session name
filename=$(basename "$selected" .md)
session_name="obsidian-$(echo "$filename" | tr '[:upper:]' '[:lower:]' | tr ' .-' '___' | sed 's/[^a-zA-Z0-9_]//g')"

# Check if we're in tmux
if [[ -z $TMUX ]]; then
    # Not in tmux - create new session and attach
    tmux new-session -s "$session_name" -c "$VAULT_DIR" "nvim '$selected'"
else
    # In tmux - check if session exists
    if ! tmux has-session -t "$session_name" 2> /dev/null; then
        # Create detached session
        tmux new-session -d -s "$session_name" -c "$VAULT_DIR" "nvim '$selected'"
    fi
    # Switch to the session
    tmux switch-client -t "$session_name"
fi
