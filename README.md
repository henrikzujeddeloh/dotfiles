# dotfiles

## zsh config

First make sure ZSH is installed: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Plugin dependancies: zsh-autosuggestions, zsh-syntax-highlighting

Add zsh config to system: `ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc`



## sshd config

Backup current sshd config file!

Add the sshd config to system: `ln -s $HOME/dotfiles/sshd_config /etc/ssh/sshd_config`

Test new config first!!! `/usr/sbin/sshd -t`

Restart SSHd service: `sudo systemctl restart ssh.service`
