#!/bin/bash

# exit script on error
set -e

# define repository
PATH_TO_BACKUP=/srv/data/Backup
PATH_TO_LOGS=/var/log/neutron_backup.txt
REPO=$PATH_TO_BACKUP/neutron
DATE=$(date +%Y%m%d)

sudo echo "START BACKUP" $DATE | sudo tee -a $PATH_TO_LOGS
sudo chown henrik $PATH_TO_LOGS

# start time
start_time=$(date -u +%s%3N)

# create borg backup
sudo borg create --stats $REPO::$DATE /home/ /etc/ >> $PATH_TO_LOGS 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $REPO >> $PATH_TO_LOGS 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $REPO >> $PATH_TO_LOGS 2>&1
fi

# stop time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))

# ping uptime kuma
curl "http://uptime.lan/api/push/Iu0zBvn9CG?status=up&msg=OK&ping=$duration"
