#!/bin/bash

# remove existing config files
rm -f $HOME/.yabairc
rm -f $HOME/.skhdrc

# create symlinks to the config files
ln -s $HOME/dotfiles/yabai/.yabairc $HOME/.yabairc
echo "Created symlink to yabai config at $HOME/.yabairc"
ln -s $HOME/dotfiles/yabai/.skhdrc $HOME/.skhdrc
echo "Created symlink to skhd config at $HOME/.skhdrc"
