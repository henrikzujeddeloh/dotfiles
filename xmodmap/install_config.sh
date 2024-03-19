#!/bin/bash

# remove existing xmodmap config
rm -f $HOME/.xmodmap
rm -f $HOME/.xprofile

# add symlinks
ln -s $HOME/dotfiles/xmodmap/.xmodmap $HOME/.xmodmap
echo "Created symlink to xmodmap config at $HOME/.xmodmap"
ln -s $HOME/dotfiles/xmodmap/.xprofile $HOME/.xprofile
echo "Created symlink to xprofile at $HOME/.xprofile"
