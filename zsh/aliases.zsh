alias e="exit"
alias lzd='lazydocker'
alias n='nvim'
alias testies='echo "test"'
# define "fd" command based on operating system
# INSTALL 'fd-find' FIRST!
if [[ `uname` == "Linux" ]]; then
    alias fd='fdfind'
elif [[ `uname` == "Darwin" ]]; then
    alias fd="fd"
else
    echo "Unknown OS!"
fi
