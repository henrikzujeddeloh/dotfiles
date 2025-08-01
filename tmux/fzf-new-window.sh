#!/usr/bin/env bash

# Use fzf to select a directory
# define fd command based on OS (run in bash so not done by "alias.zsh")
# DIRECTORY=$(find ~ -type d | fzf --prompt="Select a directory: " --preview="echo {}" --preview-window=up:30%:wrap)
if [[ $(uname) == "Linux" ]]; then
    DIRECTORY=$(fdfind . $HOME --type directory --hidden --exclude .git | fzf)
elif [[ $(uname) == "Darwin" ]]; then
    DIRECTORY=$(fd . $HOME --type directory --hidden --exclude .git | fzf)
else
    echo "Unknown OS!"
fi

# If a directory is selected, create a new window in that directory
if [ -n "$DIRECTORY" ]; then
    tmux new-window -c "$DIRECTORY"
else
    tmux new-window
fi

