alias e="exit"
alias c="clear"
alias n='nvim .'

alias sb='cd $CLOUD/Second-Brain/ && n'

# define "fd" command based on operating system
if [[ `uname` == "Linux" ]]; then
    alias fd='fdfind'
elif [[ `uname` == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi

# define obsidian neovim functions based on operating system
if [[ `uname` == "Linux" ]]; then
    alias obsidian_dup_links='obsidian_dup_links_linux'
    alias obsidian_unlinked_mentions='obsidian_unlinked_mentions_linux'
elif [[ `uname` == "Darwin" ]]; then
    alias obsidian_dup_links='obsidian_dup_links_mac'
    alias obsidian_unlinked_mentions='obsidian_unlinked_mentions_mac'
else
    echo "Unknown OS!"
fi

# docker aliases
alias dcud='docker compose up -d'
alias dcub='docker compose up --build'
alias dcubd='docker compose up --build -d'
alias dcp='docker compose --pull'
alias dlf='docker logs -f'
alias dst='docker stats'
alias dps='docker ps'

# tmux aliases
alias ta='tmux attach'
alias td='tmux detach'
alias tn='tmux new'
alias tl='tmux ls'
