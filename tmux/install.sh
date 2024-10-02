#!/bin/bash

# remove existing tmux config
rm -f ~/.tmux.conf

# create symlink to tmux config
ln -s $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
echo "Created symlink to tmux config at $HOME/.tmux.conf"
