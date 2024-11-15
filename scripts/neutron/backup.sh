#!/bin/bash

# exit script on error
set -e

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# define repository
REPO=$PATH_TO_BACKUP/Backup/neutron
DATE=$(date +%Y%m%d)

# start healthcheck.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup/start

# create borg backup
sudo borg create --stats $REPO::$DATE /home/ /etc/ > $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

# stop healthchecks.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup