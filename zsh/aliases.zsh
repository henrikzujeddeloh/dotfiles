alias e="exit"
alias c="clear"
alias h="hostname"
alias n="nvim ."
alias l="ls -lah"
alias f="fastfetch"

alias sb='cd $CLOUD/Second-Brain/ && nvim dashboard.md'
alias xdgconfig="cd $XDG_CONFIG_HOME"
alias xdgcache="cd $XDG_CACHE_HOME"
alias xdgdata="cd $XDG_DATA_HOME"
alias xdgstate="cd $XDG_STATE_HOME"

# define "fd" command based on operating system
if [[ $(uname) == "Linux" ]]; then
    alias fd='fdfind'
elif [[ $(uname) == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi

# git aliases
alias gst="git status"

# tmux aliases
alias ta='tmux attach'
alias td='tmux detach'
alias tn='tmux new'
alias tl='tmux ls'
