#!/bin/bash

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# start healthchecks.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/smart-long-test/start

# Drives to test
SATADISKS=("/dev/sda" "/dev/sdb" "/dev/sdc")
NVMEDISKS=("/dev/nvme0")

# Log file
DATE=$(date +%Y%m%d)
LOGFILE="/srv/backup/Backup/logs/smart/long_test_$DATE.log"

# Function to start a short self-test
start_test() {
  local drive=$1
  echo "Starting long SMART test on $drive at $(date)" | tee -a "$LOGFILE"
  sudo smartctl -t long "$drive" >> "$LOGFILE" 2>&1
  if [ $? -eq 0 ]; then
    echo "Long SMART test initiated successfully on $drive" | tee -a "$LOGFILE"
  else
    echo "Failed to initiate long SMART test on $drive" | tee -a "$LOGFILE"
  fi
}

# Run tests for SATA drives
for drive in "${SATADISKS[@]}"; do
  start_test "$drive"
done

# Run test for NVMe drive
for drive in "${NVMEDISKS[@]}"; do
  start_test "$drive"
done

echo "All tests initiated at $(date)" | tee -a "$LOGFILE"

# stop healthchecks.io ping
curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/smart-long-test
