#!/bin/bash

# check if hammerspoon is installed
# if ! which hammerspoon &> /dev/null
# then
#     echo "hammerspoon is not installed. Please install hammerspoon first."
#     exit 1
# fi

# remove existing hammerspoon config
rm -rf $HOME/.hammerspoon/*

# check if hammerspoon config directory exists
if [ ! -d $HOME/.hammerspoon ]; then
  mkdir -p $HOME/.hammerspoon;
fi
# add symlinks
for file in $DOTFILES/hammerspoon/*; do
  ln -s "$file" $HOME/.hammerspoon/
done
# reload hammerspoon
hs -c "hc.reload()"
