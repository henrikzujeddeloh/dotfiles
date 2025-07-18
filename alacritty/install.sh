#!/usr/bin/env bash
#
# install alacritty and config

# check if alacritty is installed
if [ ! which alacritty &> /dev/null ]; then
    echo "zsh is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install alacritty
    elif [[ $(uname) == "Darwin" ]]; then
        brew install alacritty
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# create config folder
mkdir -p "$XDG_CONFIG_HOME/alacritty"

# remove existing alacritty config
rm -f "$XDG_CONFIG_HOME/alacritty/alacritty.toml"

# add symlinks
echo "Creating symlink for alacritty.toml"
ln -s $DOTFILES/alacritty/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml

echo "[SUCCESS] alacritty and config installed."
