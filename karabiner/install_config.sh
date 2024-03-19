#!/bin/sh

# remove existing karabiner config
rm -f $HOME/.config/karabiner

# create symlinks
ln -s $HOME/dotfiles/karabiner $HOME/.config 
echo "Created symlink to karabiner config at $HOME/.config/karabiner"

launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

