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
export XDG_STATE_HOME="$HOME/.local/state"

# bootstrap .zshrc to XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# rust/cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# go
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_DIR="$XDG_DATA_HOME/nvm"

# python
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

# unison
export UNISON="$XDG_DATA_HOME/unison"

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

# add cargo binaries to PATH
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
