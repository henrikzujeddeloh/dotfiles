#!/bin/bash

# exit script on error
set -e

# source proton environment variables
source $HOME/dotfiles/scripts/proton/.env

# define server and repository
SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/Backup/proton
DATE=$(date +%Y%m%d)

# start time
start_time=$(date -u +%s%3N)

# start healthchecks.io ping
# curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/proton-backup/start

# create temporary directory for backup log
mkdir -p /tmp/backup_output

# create borg backup
sudo borg create --stats $SERVER:$REPO::$DATE /home/ /etc/ > /tmp/backup_output/${DATE}_borg_backup_proton.txt 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_proton.txt 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_proton.txt 2>&1
fi

# copy backup log to remote backup disk
scp /tmp/backup_output/${DATE}_borg_backup_proton.txt henrik@neutron.lan:/$PATH_TO_BACKUP/Backup/logs/

# remove local backup log
rm /tmp/backup_output/${DATE}_borg_backup_proton.txt

# stop healthchecks.io ping
# curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/proton-backup

# end time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))

# ping uptime kuma
curl "http://uptime.lan/api/push/HVWMV2A99s?status=up&msg=OK&ping=$duration"
