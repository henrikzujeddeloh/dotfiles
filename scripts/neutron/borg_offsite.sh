#!/bin/bash

# exit script on error
set -e

# define "server" and repository
# set 'backup' in ssh config
PATH_TO_DATA=/srv/data
PATH_TO_LOGS=/var/log/offsite_backup.txt
SERVER=backup
REPO=neutron
DATE=$(date +%Y%m%d)

sudo echo "START BACKUP" $DATE | sudo tee -a $PATH_TO_LOGS
sudo chown henrik $PATH_TO_LOGS

# start time
start_time=$(date -u +%s%3N)

# create borg backup
borg create --stats $SERVER:$REPO::$DATE $PATH_TO_DATA/Photos $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files $PATH_TO_DATA/Immich/library >> $PATH_TO_LOGS 2>&1

# prune borg backup
borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> $PATH_TO_LOGS 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    borg compact $SERVER:$REPO >> $PATH_TO_LOGS 2>&1
fi

# stop time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))

# ping uptime kuma
curl "http://uptime.lan/api/push/eaYQLb1iKW?status=up&msg=OK&ping=$duration"
