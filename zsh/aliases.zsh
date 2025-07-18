alias e="exit"
alias c="clear"
alias h="hostname"
alias n="nvim ."
alias l="ls -la"
alias f="fastfetch"

alias sb='cd $CLOUD/Second-Brain/ && nvim dashboard.md'

# define "fd" command based on operating system
if [[ $(uname) == "Linux" ]]; then
    alias fd='fdfind'
elif [[ $(uname) == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi

# tmux aliases
alias ta='tmux attach'
alias td='tmux detach'
alias tn='tmux new'
alias tl='tmux ls'
