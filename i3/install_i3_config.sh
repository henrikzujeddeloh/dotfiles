#!/bin/bash

rm -f $HOME/.config/i3/config
rm -f $HOME/.config/i3/i3status.conf

ln -s $HOME/dotfiles/i3/config $HOME/.config/i3/config
ln -s $HOME/dotfiles/i3/i3status.conf $HOME/.config/i3/i3status.conf
