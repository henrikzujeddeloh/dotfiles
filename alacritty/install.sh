#!/bin/bash

# remove existing alacritty config
rm -f $CONFIGS/alacritty/alacritty.toml

# check if alacritty config directory exists
if [ ! -d $CONFIGS/alacritty ]; then
  mkdir -p $CONFIGS/alacritty;
fi
# add symlinks
ln -s $DOTFILES/alacritty/alacritty.toml $CONFIGS/alacritty/alacritty.toml
echo "Created symlink to alacritty config at $CONFIGS/alacritty/alacritty.toml"
