#!/bin/bash

# exit script on error
set -e

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# define repository
REPO=$PATH_TO_BACKUP/Backup/neutron
DATE=$(date +%Y%m%d)

# start healthcheck.io ping
#curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup/start

# start time
start_time=$(date -u +%s%3N)

# create borg backup
sudo borg create --stats $REPO::$DATE /home/ /etc/ > $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $REPO >> $PATH_TO_BACKUP/Backup/logs/${DATE}_borg_backup_neutron.txt 2>&1
fi

# stop healthchecks.io ping
#curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/neutron-backup

# stop time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))

# ping uptime kuma
curl "http://uptime.lan/api/push/Iu0zBvn9CG?status=up&msg=OK&ping=$duration"
