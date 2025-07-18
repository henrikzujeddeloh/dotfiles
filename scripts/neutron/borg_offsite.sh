#!/bin/bash

start_time=$(date -u +%s%3N)

server=backup
repo=neutron
archive=$(date +%Y%m%d)

output="offsite backup $(date +%d-%m-%Y)"$'\n'

output+="$(borg create --stats $server:$repo::$archive $DATA_DRIVE/Photos $DATA_DRIVE/Nextcloud/henrik/files $DATA_DRIVE/Nextcloud/josina/files $DATA_DRIVE/Immich/library 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }

output+="$(borg prune --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $server:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }

if [[ $(date +%d) -eq 01 ]]; then
    output+="$(borg compact $server:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }
    output+="$(borg check --verify-data $server:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=offsite backup failed" -F "message=$output" -F "priority=5"; exit 1; }
fi

end_time=$(date -u +%s%3N)
duration=$((end_time - start_time))
output+=$(printf "Total duration: %02dh:%02dm:%02ds\n" $((duration/3600000)) $((duration%3600000/60000)) $((duration%60000/1000)))

curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=offsite backup successful" -F "message=$output" -F "priority=1"

