#!/bin/bash

rm $HOME/.yabairc
rm $HOME/.skhdrc

ln -s $HOME/dotfiles/yabai/.yabairc $HOME/.yabairc
ln -s $HOME/dotfiles/yabai/.skhdrc $HOME/.skhdrc

