# dotfiles

## zsh config

First make sure ZSH is installed: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Plugin dependancies: zsh-autosuggestions, zsh-syntax-highlighting

### zsh-autosuggestoins
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

### zsh-syntax-highlighting
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`


To apply the config file run `./zsh-config.sh`
This script deletes the current `./zshrc` file and creates a link to the one stored here



## vim config

To apply the config file run `./vim-config.sh`
This script deletes the current `./vimrc` file and creates a link to the one stored here


## sshd config

Backup current sshd config file!

Add the sshd config to system: `ln -s $HOME/dotfiles/sshd_config /etc/ssh/sshd_config`

Test new config first!!! `/usr/sbin/sshd -t`

Restart SSHd service: `sudo systemctl restart ssh.service`



## neofetch config

To apply the config file run `./neofetch-conf.sh`
This script deletes the current `config.conf` file and creates a link to the one stored here
