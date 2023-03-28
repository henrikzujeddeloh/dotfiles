# dotfiles

## zsh config

First make sure ZSH is installed: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Install plugins by running `zsh-plugins-install.sh` in [install](https://github.com/henrikzujeddeloh/install) repo.

To apply the config file run `./zsh-config.sh`.

This script deletes the current `~/.zshrc` file and creates a link to the one stored here.



## vim config

To apply the config file run `./vim-config.sh`.

This script deletes the current `~/.vimrc` file and creates a link to the one stored here.


## sshd config

Backup current sshd config file!

Add the sshd config to system: `ln -s $HOME/dotfiles/sshd_config /etc/ssh/sshd_config`

Test new config first! `/usr/sbin/sshd -t`

Restart SSHd service: `sudo systemctl restart ssh.service`



## neofetch config

To apply the config file run `./neofetch-conf.sh`.

This script deletes the current `config.conf` file and creates a link to the one stored here.
