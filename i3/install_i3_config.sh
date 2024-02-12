#!/bin/bash

rm -f $HOME/.config/i3/config
rm -f $HOME/.config/i3/i3status.conf

# check if i3 config directory exists
if [ ! -d $HOME/.config/i3 ]; then
  mkdir -p $HOME/.config/i3;
fi

# add symlinks
ln -s $HOME/dotfiles/i3/config $HOME/.config/i3/config
ln -s $HOME/dotfiles/i3/i3status.conf $HOME/.config/i3/i3status.conf
