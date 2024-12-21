#!/bin/bash

# exit script on error
set -e

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# define "server" and repository
# set 'backup' in ssh config
SERVER=backup
REPO=neutron
DATE=$(date +%Y%m%d)

# start healthchecks.io ping
#curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/offsite-backup/start

# start time
start_time=$(date -u +%s%3N)

# create borg backup
borg create --stats $SERVER:$REPO::$DATE $PATH_TO_DATA/Photos $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files > $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_offsite.txt 2>&1

# prune borg backup
borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_offsite.txt 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    borg compact $SERVER:$REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_offsite.txt 2>&1
fi

# stop time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))

# stop healthchecks.io ping
#curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/offsite-backup

# ping uptime kuma
http://uptime.lan/api/push/eaYQLb1iKW?status=up&msg=OK&ping=
