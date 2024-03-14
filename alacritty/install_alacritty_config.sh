#!/bin/bash

rm -f $HOME/.alacritty.toml

# add symlinks
ln -s $HOME/dotfiles/alacritty/.alacritty.toml $HOME/.alacritty.toml
