#!/bin/bash

# exit script on error
set -e

# source photon environment variable file
source $HOME/dotfiles/scripts/photon/.env

# define server and repository
SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/Backup/photon
DATE=$(date +%Y%m%d)

# create borg backup
sudo borg create --stats --progress --verbose $SERVER:$REPO::$DATE /Users/henrikzujeddeloh/

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $SERVER:$REPO
fi
