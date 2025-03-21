#!/bin/bash

# check if tmux is installed
if ! which tmux &> /dev/null
then
    echo "tmux is not installed. Please install tmux first."
    exit 1
fi

# remove existing tmux config
rm -f ~/.tmux.conf

# create symlink to tmux config
ln -s $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
echo "Created symlink to tmux config at $HOME/.tmux.conf"
