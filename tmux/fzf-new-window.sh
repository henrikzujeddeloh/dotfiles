#!/bin/bash

# Use fzf to select a directory
# DIRECTORY=$(find ~ -type d | fzf --prompt="Select a directory: " --preview="echo {}" --preview-window=up:30%:wrap)
DIRECTORY=$(fd . $HOME --type directory --hidden --exclude .git | fzf)

# If a directory is selected, create a new window in that directory
if [ -n "$DIRECTORY" ]; then
    tmux new-window -c "$DIRECTORY"
else
    tmux new-window
fi

