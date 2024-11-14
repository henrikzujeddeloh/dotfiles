#!/bin/bash

set -e

source $HOME/dotfiles/scripts/neutron/.env

REPO=$PATH_TO_BACKUP/Backup/neutron
DATE=$(date +%Y%m%d)

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup/start

sudo borg create --stats $REPO::$DATE /home/ /etc/ > $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup
