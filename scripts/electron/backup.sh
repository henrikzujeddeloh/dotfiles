#!/bin/bash

# exit script on error
set -e

# define server and repository
PATH_TO_BACKUP=/srv/data/Backup
PATH_TO_LOGS=/var/log/backup
SERVER=henrik@neutron.lan
REPO=$PATH_TO_BACKUP/electron
DATE=$(date +%Y%m%d)

# start time
start_time=$(date -u +%s%3N)

# create temporary directory for backup log
mkdir -p /tmp/backup_output

# create borg backup
sudo borg create --stats $SERVER:$REPO::$DATE /home/ /etc/ > /tmp/backup_output/${DATE}_borg_backup_electron.txt 2>&1

# prune borg backup
sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_electron.txt 2>&1

# on the first day of the month, compact borg repo
if [[ $(date +%d) -eq 01 ]]; then
    sudo borg compact $SERVER:$REPO >> /tmp/backup_output/${DATE}_borg_backup_electron.txt 2>&1
fi

# copy backup log to remote backup disk
scp /tmp/backup_output/${DATE}_borg_backup_electron.txt henrik@neutron.lan:/$PATH_TO_LOGS

# remove local backup log
rm /tmp/backup_output/${DATE}_borg_backup_electron.txt

# stop time
end_time=$(date -u +%s%3N)

# duration
duration=$(($end_time - $start_time))
 
# ping uptime kuma
curl "http://uptime.lan/api/push/TSZZsIcaal0EufHNRjfQzWmSYm2j3FNv?status=up&msg=OK&ping=$duration"
