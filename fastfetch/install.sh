#!/usr/bin/env bash
#
# install fastfetch and config

# check if fastfetch is installed
if ! [ -x "$(command -v fastfetch)" ]; then
    echo "fastfetch is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install fastfetch
    elif [[ $(uname) == "Darwin" ]]; then
        brew install fastfetch
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# create config folder
mkdir -p "$XDG_CONFIG_HOME/fastfetch"

# remove existing fastfetch config
rm -f "$XDG_CONFIG_HOME/fastfetch/config.jsonc"

# add symlinks
echo "Creating symlink for config.jsonc"
ln -s $DOTFILES/fastfetch/config.jsonc $XDG_CONFIG_HOME/fastfetch/config.jsonc

echo "[SUCCESS] fastfetch and config installed."
