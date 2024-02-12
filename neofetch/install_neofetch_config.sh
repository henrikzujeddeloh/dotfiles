#!/bin/bash

rm -f $HOME/.config/neofetch/config.conf

# check if neofetch config directory exists
if [ ! -d $HOME/.config/neofetch ]; then
  mkdir -p $HOME/.config/neofetch;
fi

# create symlinks
ln -s $HOME/dotfiles/neofetch/config.conf $HOME/.config/neofetch/config.conf 
