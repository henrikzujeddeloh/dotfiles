#!/bin/bash

# define server and repository
PATH_TO_BACKUP=/srv/data/Backup
SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/photon
DATE=$(date +%Y%m%d-%H%M)

# create borg backup
sudo borg create --stats --progress --verbose $SERVER:$REPO::$DATE /Users/henrikzujeddeloh/

# prune borg backup
sudo borg prune --list --stats --keep-within=1d --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $SERVER:$REPO
fi
