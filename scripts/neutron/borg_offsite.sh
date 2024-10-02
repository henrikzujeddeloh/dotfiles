#!/bin/bash

set -e

source $HOME/scripts/neutron/set_env.sh

# set 'backup' in ssh config
export SERVER=backup
export REPO=neutron
export DATE=$(date +%Y%m%d)

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/offsite-backup/start

borg create --stats $SERVER:$REPO::$DATE $PATH_TO_DATA/Photos $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files > $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_offsite.txt 2>&1

borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_offsite.txt 2>&1

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/offsite-backup
