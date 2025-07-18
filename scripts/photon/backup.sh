#!/usr/bin/env bash
#
# backup photon to backup server using borg

# define server and repository
repo=$BACKUP_DIR/photon
archive=$(date +%Y%m%d-%H%M)

# create borg backup
sudo borg create --progress --stats --compression zstd,6 $BACKUP_SERVER:$repo::$archive /Users/henrikzujeddeloh/ --exclude '/Users/henrikzujeddeloh/Library/'

# prune borg backup
sudo borg prune --list --stats --keep-within=1d --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $BACKUP_SERVER:$repo

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $BACKUP_SERVER:$repo
fi
