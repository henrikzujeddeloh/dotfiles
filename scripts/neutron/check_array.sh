#!/usr/bin/env bash

# RAID device to monitor
raid_device="/dev/md0"

# Function to send Gotify notification
send_notification() {
    local message="$1"
    curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "message=$message" -F "title=Disk Array Alert" -F "priority=10"
}

# Check RAID status using mdadm exit codes
sudo mdadm --detail --test "$raid_device" > /dev/null
status=$?

case $status in
    0)
        exit 0
        ;;
    1)
        send_notification "RAID array has at least one failed device"
        exit 1
        ;;
    2)
        send_notification "RAID array has multiple failed devices and is unusable"
        exit 2
        ;;
    4)
        send_notification "Error getting information about the RAID device"
        exit 4
        ;;
    *)
        send_notification "Unknown RAID status: $status"
        exit $status
        ;;
esac


