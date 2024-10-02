#!/bin/bash

set -e

source $HOME/scripts/electron/set_env.sh

export SERVER=henrik@neutron.lan
export REPO=$PATH_TO_BACKUP/Backup/electron
export DATE=$(date +%Y%m%d)

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/electron-backup/start

mkdir -p /tmp/backup_output

sudo borg create --stats $SERVER:$REPO::$DATE /home/ /etc/ > /tmp/backup_output/${DATE}_borg_backup_electron.txt 2>&1

sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_electron.txt 2>&1

scp /tmp/backup_output/${DATE}_borg_backup_electron.txt henrik@neutron.lan:/$PATH_TO_BACKUP/Backup/logs/

rm /tmp/backup_output/${DATE}_borg_backup_electron.txt

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/electron-backup
 
