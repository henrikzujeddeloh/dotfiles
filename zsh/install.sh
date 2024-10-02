#!/bin/bash

# install required zsh plugins
echo "Installing zsh plugins"
/bin/bash $DOTFILES/zsh/install_zsh_plugins.sh
echo "Installed zsh plugins"

# remove existing zsh config
rm -f $HOME/.zshrc

# create symlink to zsh config
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
echo "Created symlink to zsh config at $HOME/.zshrc"
