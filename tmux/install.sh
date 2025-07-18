#!/usr/bin/env bash
#
# install tmux and config

# check if tmux is installed
if [ ! which tmux &> /dev/null ]; then
    echo "tmux is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install tmux
    elif [[ $(uname) == "Darwin" ]]; then
        brew install tmux
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# create config folder
mkdir -p "$XDG_CONFIG_HOME/tmux"

# remove existing tmux config
rm -f "$XDG_CONFIG_HOME/tmux/tmux.conf"

# add symlinks
echo "Creating symlink for tmux.conf"
ln -s $DOTFILES/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf

echo "[SUCCESS] tmux and config installed."
