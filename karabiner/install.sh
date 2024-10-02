#!/bin/sh

# remove existing karabiner config
rm -f $CONFIGS/karabiner

# create symlinks
ln -s $DOTFILES/karabiner $CONFIGS
echo "Created symlink to karabiner config at $CONFIGS/karabiner"

launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

