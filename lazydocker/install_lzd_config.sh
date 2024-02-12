#!/bin/bash

rm -f $HOME/.config/lazydocker/config.yml

# check if lazydocker config directory exists
if [ ! -d $HOME/.config/lazydocker ]; then
  mkdir -p $HOME/.config/lazydocker;
fi

# add symlinks
ln -s $HOME/dotfiles/lazydocker/config.yml $HOME/.config/lazydocker/config.yml
