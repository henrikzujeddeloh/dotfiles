#!/usr/bin/env bash
#
# install npm and config

# check if npm is installed
if ! [ -x "$(command -v npm)" ]; then
    echo "npm is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install npm
    elif [[ $(uname) == "Darwin" ]]; then
        brew install npm
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# create config folder
mkdir -p "$XDG_CONFIG_HOME/npm"

# remove existing npm config
rm -f "$XDG_CONFIG_HOME/npm/npmrc"

# add symlinks
echo "Creating symlink for npmrc"
ln -s $DOTFILES/npm/npmrc $XDG_CONFIG_HOME/npm/npmrc

echo "[SUCCESS] npm and config installed."
