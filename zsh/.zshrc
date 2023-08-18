# path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# set ZSH theme
ZSH_THEME="robbyrussell"

# disables compatability fix promt (relevant for macOS)
ZSH_DISABLE_COMPFIX=true

# disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE=true

# automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"


### LOAD PLUGINS
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git z history docker-compose docker mosh systemd sudo dirhistory aliases zsh-autosuggestions zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


### ENVIRONMENT VARIABLES

# Defines find command that fzf uses
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!vendor/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# makes /usr/local/bin binaries executable from anywhere
export PATH=$PATH:$HOME/.local/bin

# makes vim devault editor and viewer
export VISUAL=vim
export EDITOR=vim

export PING_KEY=XqvodhqCimKKe0HNSSxKCg


### ALISASES

alias e="exit"




### KEYBINDS

# Bind CTRL-O to enter directory using fzf
bindkey -s '^o' 'cd_with_fzf\n'

# Bind CTRL-E to vim file using fzf
bindkey -s '^e' 'vim_with_fzf\n'




### FUNCTIONS

# Search directory under home directory using fzf and cd into it
cd_with_fzf() {
cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && clear
}

# Search for file under home directory using fzf and edit using vim
vim_with_fzf() {
cd $HOME && vim "$(fd -t f -H | fzf)"
}

# Recursively rename images in directory to creation date
rename_to_capture() {
exiftool -R -d '%Y-%m-%d_%H-%M-%S%%-02.c.%%e' '-filename<CreateDate' *
}

# Move all raw files into raw subfolder
move_raw() {
mkdir -p RAW
find -E . -iregex '.*\.(RAF|CR2)' -exec mv '{}' ./RAW \;
}

cd_photos() {
year=`date +'%Y'`
cd /Volumes/Photos/$year
}
