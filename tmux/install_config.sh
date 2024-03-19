#!/bin/bash

# remove existing tmux config
rm -f ~/.tmux.conf

# create symlink to tmux config
ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
echo "Created symlink to tmux config at $HOME/.tmux.conf"
