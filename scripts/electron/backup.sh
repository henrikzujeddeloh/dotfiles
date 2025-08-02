#!/usr/bin/env bash

start_time=$(date -u +%s%3N)

repo=$BACKUP_DIR/electron
archive=$(date +%Y%m%d)

output="electron backup $(date +%d-%m-%Y)"$'\n'

output+="$(sudo borg create --stats --compression zstd,6 $BACKUP_SERVER:$repo::$archive /home/ /etc/ 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }

output+="$(sudo borg prune --stats --keep-daily 7 --keep-weekly 4 --keep-monthly 12 $BACKUP_SERVER:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }

if [[ $(date +%d) -eq 01 ]]; then
    output+="$(sudo borg compact $BACKUP_SERVER:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }
    output+="$(sudo borg check --verify-data $BACKUP_SERVER:$repo 2>&1)"$'\n' || { curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=electron backup failed" -F "message=$output" -F "priority=5"; exit 1; }
fi

end_time=$(date -u +%s%3N)
duration=$((end_time - start_time))
output+=$(printf "Total duration: %02dh:%02dm:%02ds\n" $((duration/3600000)) $((duration%3600000/60000)) $((duration%60000/1000)))

if [[ $(date +%d) -eq 01 ]]; then
    curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=electron backup successful" -F "message=$output" -F "priority=1"
fi

curl -sSf -o /dev/null --request POST "$INFLUXDB_URL/api/v2/write?org=personal&bucket=bucket&precision=ns" \
  --header "Authorization: Token $INFLUXDB_API" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary "backup_duration,host=$HOSTNAME dur=$duration"
