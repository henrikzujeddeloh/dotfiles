#!/bin/bash

# Drives to test
DISKS=("/dev/sda" "/dev/sdb" "/dev/nvme0")

# Function to start a short self-test
start_test() {
  local drive=$1
  output+="$(sudo smartctl -t short "$drive" 2>&1)"$'\n'
  if [ $? -ne 0 ]; then
    curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=$drive Short SMART Test Alert" -F "message=$output" -F "priority=5"
  fi
}

# Run tests for SATA drives
for drive in "${DISKS[@]}"; do
  start_test "$drive"
done

curl -sSf -o /dev/null "$GOTIFY_URL/message?token=$GOTIFY_API" -F "title=Short SMART Tests Started" -F "message=$output" -F "priority=1"
