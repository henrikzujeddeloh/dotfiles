#!/bin/bash

/bin/bash install_zsh_plugins.sh

rm $HOME/.zshrc

ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
