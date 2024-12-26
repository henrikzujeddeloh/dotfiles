#!/bin/bash

# Drives to test
SATADISKS=("/dev/sda" "/dev/sdb" "/dev/sdc")
NVMEDISKS=("/dev/nvme0")

# Log file
DATE=$(date +%Y%m%d)
LOGFILE="/var/log/smart/long_test_$DATE.log"

# Function to start a short self-test
start_test() {
  local drive=$1
  echo "Starting short SMART test on $drive at $(date)" | tee -a "$LOGFILE"
  sudo smartctl -t short "$drive" >> "$LOGFILE" 2>&1
  if [ $? -eq 0 ]; then
    echo "Short SMART test initiated successfully on $drive" | tee -a "$LOGFILE"
  else
    echo "Failed to initiate SMART test on $drive" | tee -a "$LOGFILE"
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
