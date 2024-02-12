#!/bin/bash

rm -f $HOME/.yabairc
rm -f $HOME/.skhdrc

ln -s $HOME/dotfiles/yabai/.yabairc $HOME/.yabairc
ln -s $HOME/dotfiles/yabai/.skhdrc $HOME/.skhdrc

