#!/bin/bash

# check if zsh is installed
if ! which zsh &> /dev/null
then
    echo "zsh is not installed. Please install zsh first."
    exit 1
fi

# install required zsh plugins
echo "Installing zsh plugins"
/bin/bash $HOME/dotfiles/zsh/install_zsh_plugins.sh
echo "Installed zsh plugins"

# remove existing zsh config
rm -f $HOME/.zshrc

# create symlink to zsh config
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
echo "Created symlink to zsh config at $HOME/.zshrc"
