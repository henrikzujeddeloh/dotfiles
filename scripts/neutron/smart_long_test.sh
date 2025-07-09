#!/bin/bash

GOTIFY_APP_TOKEN="AHgbe0nz1_eLwOG"

# Drives to test
DISKS=("/dev/sda" "/dev/sdb" "/dev/nvme0")

# Function to start a short self-test
start_test() {
  local drive=$1
  output+="$(sudo smartctl -t long "$drive" 2>&1)"
  if [ $? -ne 0 ]; then
    curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=$drive Long SMART Test Alert" -F "message=$output" -F "priority=5"
  fi
}

# Run tests for SATA drives
for drive in "${DISKS[@]}"; do
  start_test "$drive"
done

curl -sSf -o /dev/null "http://gotify.lan/message?token=$GOTIFY_APP_TOKEN" -F "title=Long SMART Tests Started" -F "message=$output" -F "priority=1"
