#!/bin/bash

rm -f $CONFIGS/neofetch/config.conf

# check if neofetch config directory exists
if [ ! -d $CONFIGS/neofetch ]; then
  mkdir -p $CONFIGS/neofetch;
fi

# create symlinks
ln -s $DOTFILES/neofetch/config.conf $CONFIGS/neofetch/config.conf 
echo "Created symlink to neofetch config at $CONFIGS/neofetch/neofetch.toml"
