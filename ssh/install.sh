#!/bin/bash

# Remove the existing ssh config file
rm -f $HOME/.ssh/config

# Create a symbolic link to the ssh config file
ln -s $DOTFILES/ssh/config $HOME/.ssh/config
echo "Created a symbolic link to the $HOME/.ssh/config file"
