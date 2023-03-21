# dotfiles

## zsh config
First make sure ZSH is installed: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Plugin dependancies: zsh-autosuggestions, zsh-syntax-highlighting

Add zsh config to system: `ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc`


## sshd config
To add the sshd config to system: `ln -s $HOME/dotfiles/sshd_config /etc/ssh/sshd_config`
