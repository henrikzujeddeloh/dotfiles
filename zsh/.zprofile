#!/bin/sh
#
# set env variables (runs before .zshrc)

# default programs
export EDITOR="nvim"
export BROWSER="firefox"

# XDG base dir
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# bootstrap .zshrc to XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# other directories
export DOTFILES="$HOME/dotfiles"
export FUNCTIONS="$DOTFILES/functions"
export SCRIPTS="$DOTFILES/scripts/$HOSTNAME"
export CLOUD="$HOME/Cloud"

# set hostname
export HOSTNAME="$(hostname)"

# other useful variables
export BACKUP_SERVER="henrik@neutron.lan"
export BACKUP_DIR="/srv/data/Backup"
export GOTIFY_URL="http://gotify.lan"
export GOTIFY_API="AHgbe0nz1_eLwOG"
export KANBOARD_API="179d878a17e4e95b01e38dd180ad4788f650d483693ec768ba1c22d44d7d"

# variables for neutron
if [ "$HOSTNAME" = "neutron" ]; then
    export DATA_DRIVE="/srv/data"
fi

# add custom functions to PATH
export PATH="$FUNCTIONS:$PATH"
