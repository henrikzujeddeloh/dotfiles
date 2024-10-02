#!/bin/bash

rm -f $CONFIGS/i3/config
rm -f $CONFIGS/i3/i3status.conf

# check if i3 config directory exists
if [ ! -d $CONFIGS/i3 ]; then
  mkdir -p $CONFIGS/i3;
fi

# add symlinks
ln -s $DOTFILES/i3/config $CONFIGS/i3/config
echo "Created symlink to i3 config at $CONFIGS/i3/config"
ln -s $DOTFILES/i3/i3status.conf $CONFIGS/i3/i3status.conf
echo "Created symlink to i3-status config at $CONFIGS/i3/i3status.conf"
