#!/bin/bash

# remove existing alacritty config
rm -f $HOME/.alacritty.toml

# add symlinks
ln -s $HOME/dotfiles/alacritty/.alacritty.toml $HOME/.alacritty.toml
echo "Created symlink to alacritty config at $HOME/.alacritty.toml"
