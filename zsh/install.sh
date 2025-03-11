#!/bin/bash

# install required zsh plugins
echo "Installing zsh plugins"
/bin/bash /home/henrik/dotfiles/zsh/install_zsh_plugins.sh
echo "Installed zsh plugins"

# remove existing zsh config
rm -f $HOME/.zshrc

# create symlink to zsh config
ln -s /home/henrik/dotfiles/zsh/.zshrc $HOME/.zshrc
echo "Created symlink to zsh config at $HOME/.zshrc"
