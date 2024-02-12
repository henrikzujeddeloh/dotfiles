#!/bin/bash

# install required zsh plugins
/bin/bash install_zsh_plugins.sh

rm -f $HOME/.zshrc

ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
