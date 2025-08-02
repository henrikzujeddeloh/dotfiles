#!/usr/bin/env bash
#
# install ncdu and config

# check if ncdu is installed
if ! [ -x "$(command -v ncdu)" ]; then
    echo "ncdu is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install ncdu
    elif [[ $(uname) == "Darwin" ]]; then
        brew install ncdu
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# create config folder
mkdir -p "$XDG_CONFIG_HOME/ncdu"

# remove existing ncdu config
rm -f "$XDG_CONFIG_HOME/ncdu/config"

# add symlinks
echo "Creating symlink for config"
ln -s $DOTFILES/ncdu/config $XDG_CONFIG_HOME/ncdu/config

echo "[SUCCESS] ncdu and config installed."
