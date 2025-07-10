#!/bin/bash

start_time=$(date -u +%s%3N)

PATH_TO_DATA=/srv/data
GOTIFY_APP_TOKEN="AHgbe0nz1_eLwOG"
SERVER=backup
REPO=neutron
DATE=$(date +%Y%m%d)

output="offsite backup $(date +%d-%m-%Y)"$'\n'

output+="$(borg create --stats $SERVER:$REPO::$DATE $PATH_TO_DATA/Photos $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files $PATH_TO_DATA/Immich/library 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }

output+="$(borg prune --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $SERVER:$REPO 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }

if [[ $(date +%d) -eq 01 ]]; then
    output+="$(borg compact $SERVER:$REPO 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }
    output+="$(borg check --verify-data $SERVER:$REPO 2>&1)"$'\n' || { curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }
fi

end_time=$(date -u +%s%3N)
duration=$((end_time - start_time))
output+=$(printf "Total duration: %02dh:%02dm:%02ds\n" $((duration/3600000)) $((duration%3600000/60000)) $((duration%60000/1000)))

curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=offsite backup successful" -F "message=$output" -F "priority=1"

