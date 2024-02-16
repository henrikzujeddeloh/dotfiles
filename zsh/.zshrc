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

# TAB suggest hidden files/directories
setopt globdots

### LOAD PLUGINS
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git z history docker-compose docker mosh systemd sudo dirhistory aliases zsh-autosuggestions zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh


### ENVIRONMENT VARIABLES

# Defines find command that fzf uses
# INSTALL fd-find FIRST!
if [[ `uname` == "Linux" ]]; then
    export FZF_DEFAULT_COMMAND='fdfind --hidden --type f'
elif [[ `uname` == "Darwin" ]]; then
    export FZF_DEFAULT_COMMAND='fd --hidden --type f'
else
    echo "Unknown OS!"
fi
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# add some paths to PATH
export PATH=$PATH:$HOME/.local/bin
export PATH="/usr/local/bin:$PATH"

# makes vim devault editor and viewer
export VISUAL=nvim
export EDITOR=nvim


### ALISASES

alias e="exit"

alias lzd='lazydocker'

alias n='nvim'

# define "fd" command based on operating system
# INSTALL fd-find FIRST!
if [[ `uname` == "Linux" ]]; then
    alias fd='fdfind'
elif [[ `uname` == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi


### KEYBINDS

# Bind CTRL-O to enter directory using fzf
bindkey -s '^o' 'cd_with_fzf\n'


### FUNCTIONS

# Search directory under home directory using fzf and cd into it
cd_with_fzf() {
    cd $HOME && cd "$(fd --type directory --hidden --exclude .git | fzf)" && clear
}

# Convert markdown to html for blog
convert_post() {
    pandoc --standalone --template ../template.html post.md -o post.html
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

# move to particular year in NAS photo storage
cd_photos() {
    year=`date +'%Y'`
    cd /Volumes/Photos/$year
}

# find RAW images without matching JPG
diff_raw_jpg() {
    echo "RAW files without existing JPG"
    for filename in ./*; do
        name=${filename##*/}
        base=${name%.*}
        if [[ -z $(find .. -name "$base.*" -not -path "../RAW*") ]]; then
            echo $name
        fi
    done
}

# remove RAW images without existing corresponding JPG
rm_orphan_raw() {
    echo "Remove RAW without existing JPG? "
    read reply
    echo

    if [[ $reply =~ ^[Yy]$ ]]
    then
        for filename in ./*; do
            name=${filename##*/}
            base=${name%.*}
            if [[ -z $(find .. -name "$base.*" -not -path "../RAW*") ]]; then
                echo "removing $name"
                rm $name
            fi
        done

    fi
}



### Display hostname on login
hostname=$(hostname)
figurine -f "ANSI Regular.flf" $hostname
