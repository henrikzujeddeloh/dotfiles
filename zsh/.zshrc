# Directories
export DOTFILES="$HOME/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export FUNCTIONS="$DOTFILES/functions"
export PROJECTS="$HOME/projects"
export CLOUD="$HOME/Cloud"
export CONFIGS="$HOME/.config"

# path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# set ZSH theme
ZSH_THEME="robbyrussell"

# disables compatibility fix prompt (relevant for macOS)
ZSH_DISABLE_COMPFIX=true

# disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE=true

# automatically update without prompting.
DISABLE_UPDATE_PROMPT=true

# TAB suggest hidden files/directories
setopt globdots

### LOAD PLUGINS
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git sudo dirhistory aliases zsh-autosuggestions zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh

# Add to PATH
path=(
    $path                           # Keep existing PATH entries
    $FUNCTIONS
    $HOME/.local/bin
    /usr/local/bin
)
# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH


# makes vim default editor and viewer
set -o vi # use vim in terminal
export VISUAL=nvim
export EDITOR=nvim

export BROWSER="firefox"

### custom keybinds
bindkey -s '^O' 'source $FUNCTIONS/cd_with_fzf^M'
bindkey '^J' autosuggest-accept

# CTRL-T: fzf files
# CTRL-R: fzf command history

### custom aliases
. $DOTFILES/zsh/aliases.zsh

### Display hostname on login
echo $(hostname)
