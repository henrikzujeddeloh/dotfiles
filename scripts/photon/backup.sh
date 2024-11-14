#!/bin/bash

source $HOME/dotfiles/scripts/photon/.env

SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/Backup/photon
DATE=$(date +%Y%m%d)

sudo borg create --stats --progress --verbose $SERVER:$REPO::$DATE /Users/henrikzujeddeloh/

sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO
