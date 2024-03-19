alias e="exit"
alias lzd='lazydocker'
alias n='nvim'

# define "fd" command based on operating system
if [[ `uname` == "Linux" ]]; then
    alias fd='fdfind'
elif [[ `uname` == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi

# docker aliases
alias dcud='docker compose up -d'
alias dcub='docker compose up --build'
alias dcubd='docker compose up --build -d'
alias dcp='docker compose --pull'
alias dps='docker ps'
alias dst='docker stats'

# tmux aliases
alias ta='tmux attach'
