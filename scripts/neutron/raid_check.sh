#!/bin/bash

# Set RAID device
RAID_DEVICE="md0" # Change this to your RAID device

# Start the consistency check
echo "Starting consistency check on RAID array: $RAID_DEVICE"
echo check | sudo tee /sys/block/$RAID_DEVICE/md/sync_action

# Monitor progress
while :; do
    # Get the current status of /proc/mdstat
    clear
    echo "RAID Consistency Check Progress:"
    echo "================================"
    cat /proc/mdstat

    # Check if the consistency check is still running
    if cat /proc/mdstat | grep -q "\[.*>.*\]"; then
        sleep 5 # Wait 5 seconds before refreshing
    else
        echo "================================"
        echo "Consistency check completed!"
        break
    fi
done

# Output final RAID details
echo "Final RAID Status:"
sudo mdadm --detail /dev/$RAID_DEVICE

echo "RAID Mismatch Count:"
cat /sys/block/$RAID_DEVICE/md/mismatch_cnt
