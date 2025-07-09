#!/bin/bash

start_time=$(date -u +%s%3N)

GOTIFY_APP_TOKEN="<app_token>"
PATH_TO_BACKUP=/srv/data/Backup
REPO=$PATH_TO_BACKUP/electron
SERVER=henrik@neutron.lan
DATE=$(date +%Y%m%d)

output="electron backup $(date +%d-%m-%Y)"$'\n'
output+="----------------------------------------------"$'\n'

output+="$(sudo borg create --stats $SERVER:$REPO::$DATE /home/ /etc/ 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }
output+="----------------------------------------------"$'\n'

output+="$(sudo borg prune --list --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }
output+="----------------------------------------------"$'\n'

if [[ $(date +%d) -eq 01 ]]; then
    output+="$(sudo borg compact $SERVER:$REPO 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }
fi
output+="----------------------------------------------"$'\n'

end_time=$(date -u +%s%3N)
duration=$((end_time - start_time))
output+=$(printf "Total duration: %02dh:%02dm:%02ds\n" $((duration/3600000)) $((duration%3600000/60000)) $((duration%60000/1000)))

curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=electron backup successful" -F "message=$output" -F "priority=1"
