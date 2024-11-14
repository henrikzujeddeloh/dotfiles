#!/bin/bash

# pass errors
set -e

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# compact all borg backup repositories
sudo borg compact $PATH_TO_BACKUP/Backup/neutron
sudo borg compact $PATH_TO_BACKUP/Backup/proton
sudo borg compact $PATH_TO_BACKUP/Backup/electron
sudo borg compact $PATH_TO_BACKUP/Backup/photon
