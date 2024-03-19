#!/bin/bash

# install required zsh plugins
/bin/bash $HOME/dotfiles/zsh/install_zsh_plugins.sh
echo "Installed zsh plugins"

# remove existing zsh config
rm -f $HOME/.zshrc

# create symlink to zsh config
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
echo "Created symlink to zsh config at $HOME/.zshrc"
