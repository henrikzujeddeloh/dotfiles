#!/bin/bash

# check if yabai is installed
if ! which yabai &> /dev/null
then
    echo "yabai is not installed. Please install yabai first."
    exit 1
fi

# check if skhd is installed
if ! which skhd &> /dev/null
then
    echo "skhd is not installed. Please install skhd first."
    exit 1
fi

# remove existing config files
rm -f $HOME/.yabairc
rm -f $HOME/.skhdrc

# create symlinks to the config files
ln -s $DOTFILES/yabai/.yabairc $HOME/.yabairc
echo "Created symlink to yabai config at $HOME/.yabairc"
ln -s $DOTFILES/yabai/.skhdrc $HOME/.skhdrc
echo "Created symlink to skhd config at $HOME/.skhdrc"
