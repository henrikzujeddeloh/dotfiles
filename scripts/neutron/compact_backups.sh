#!/bin/bash

# pass errors
set -e

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# compact all borg backup repositories
echo "Compacting neutron backup"
sudo borg compact $PATH_TO_BACKUP/Backup/neutron

echo "Compacting proton backup"
sudo borg compact $PATH_TO_BACKUP/Backup/proton

echo "Compacting electron backup"
sudo borg compact $PATH_TO_BACKUP/Backup/electron

echo "Compacting photon backup"
sudo borg compact $PATH_TO_BACKUP/Backup/photon

echo "Compacting off-site backup"
borg compact backup:neutron
