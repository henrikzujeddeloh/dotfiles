#!/bin/bash

# exit script on error
set -e

# source proton environment variables
source $HOME/dotfiles/scripts/proton/.env

# define server and repository
SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/Backup/proton
DATE=$(date +%Y%m%d)

# start healthchecks.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/proton-backup/start

# create temporary directory for backup log
mkdir -p /tmp/backup_output

# create borg backup
sudo borg create --stats $SERVER:$REPO::$DATE /home/ /etc/ > /tmp/backup_output/${DATE}_borg_backup_proton.txt 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_proton.txt 2>&1

# copy backup log to remote backup disk
scp /tmp/backup_output/${DATE}_borg_backup_proton.txt henrik@neutron.lan:/$PATH_TO_BACKUP/Backup/logs/

# remove local backup log
rm /tmp/backup_output/${DATE}_borg_backup_proton.txt

# stop healthchecks.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/proton-backup