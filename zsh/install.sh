#!/usr/bin/env bash
#
# install zsh and config

set -e

# check if zsh is installed
if [ ! which zsh &> /dev/null ]; then
    echo "zsh is not installed. Installing..."
    if [[ $(uname) == "Linux" ]]; then
        sudo apt install zsh
    elif [[ $(uname) == "Darwin" ]]; then
        brew install zsh
    else
        echo "[ERROR] Unknown OS!"
        exit 1
    fi
fi

# temporarily set necessary env variables
# since .zprofile not yet installed
ZDOTDIR="$HOME/.config/zsh"
XDG_DATA_HOME="$HOME/.local/share"

# create config folder
mkdir -p "$ZDOTDIR"

# remove existing zsh config
rm -f $HOME/.zprofile
rm -f $ZDOTDIR/.zshrc

# create symlink to .zprofile and .zshrc
echo "Creating symlink for .zprofile"
ln -s $HOME/dotfiles/zsh/.zprofile $HOME/.zprofile
echo "Creating symlink for .zshrc"
ln -s $HOME/dotfiles/zsh/.zshrc $ZDOTDIR/.zshrc

# install zsh plugins
mkdir -p "$XDG_DATA_HOME/zsh/plugins"
plugins=( "zsh-autosuggestions" "zsh-syntax-highlighting" )
plugin_repos=( "zsh-users/zsh-autosuggestions.git" "zsh-users/zsh-syntax-highlighting.git" )

for ((idx=0; idx<${#plugins[@]}; ++idx))
do
    if [ ! -d "$XDG_DATA_HOME/zsh/plugins/${plugins[idx]}/" ]; then
        echo "Installing ${plugins[idx]} plugin"
        git clone git@github.com:${plugin_repos[idx]} "$XDG_DATA_HOME/zsh/plugins/${plugins[idx]}"
    fi
done

echo "[SUCCESS] zsh and config installed."
