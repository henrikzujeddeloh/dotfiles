#!/usr/bin/env bash

start_time=$(date -u +%s%3N)

RAID_DEVICE="md0"

output=""
output+="$(sudo /usr/share/mdadm/checkarray --all --idle --quiet 2>&1)"
if [ $? -ne 0 ]; then
    curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=RAID Consistency Check Alert" -F "message=$output" -F "priority=10"
    exit 1;
fi

# Monitor progress
while :; do
    # Check if the consistency check is still running
    if /usr/share/mdadm/checkarray --all --status | grep -q "check"; then
        sleep 5 # Wait 5 seconds before refreshing
    else
        # Output final RAID details
        sleep 5

        output+="Final RAID Array Details"$'\n' 
        output+="$(sudo mdadm --detail /dev/$RAID_DEVICE 2>&1)"$'\n'

        output+="Mismatch Count:"$'\n' 
        output+="$(cat /sys/block/$RAID_DEVICE/md/mismatch_cnt 2>&1)"$'\n'
        break
    fi
done


end_time=$(date -u +%s%3N)
duration=$((end_time - start_time))
output+=$(printf "Total duration: %02dh:%02dm:%02ds\n" $((duration/3600000)) $((duration%3600000/60000)) $((duration%60000/1000)))

curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=RAID Consistency Check Complete" -F "message=$output" -F "priority=1"
