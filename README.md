# dotfiles

**PULL THIS REPO INTO HOME DIRECTORY!** 

## Usage

Run install script to install the respective configuration.
The scripts delete the current configuration and create a new symbolic link to the configuration in this repository.

### sshd config

Backup current sshd config file!

Add the sshd config to system: `ln -s $HOME/dotfiles/sshd_config /etc/ssh/sshd_config`

Test new config first! `/usr/sbin/sshd -t`

Restart SSHd service: `sudo systemctl restart ssh.service`
