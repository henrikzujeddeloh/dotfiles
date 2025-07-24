#!/usr/bin/env bash

# Function to send Gotify notification
send_notification() {
    local message="$1"
    curl -X POST \
        "$GOTIFY_URL/message?$GOTIFY_API" \
        -F "message=$message" \
        -F "title=SMART Health Alert"
}

# Detailed SMART status check function
detailed_report=""
overall_status=0

# Get all disk devices
drives=$(lsblk -d -o NAME | grep -E '^sd|^nvme')

for drive in $drives; do

    # Run SMART status check
    sudo smartctl -H "/dev/$drive" -q silent
    status=$?

    # Detailed bit-level analysis
    error_bits=()

    # Check each bit
    for ((i=0; i<8; i++)); do
        if ((status & (2**i))); then
            case $i in
                0) error_bits+=("Command line parse error") ;;
                1) error_bits+=("Device open failed") ;;
                2) error_bits+=("SMART command failed") ;;
                3) error_bits+=("DISK FAILING") ;;
                4) error_bits+=("Prefail Attributes <= threshold") ;;
                5) error_bits+=("Attributes were <= threshold in past") ;;
                6) error_bits+=("Device error log contains errors") ;;
                7) error_bits+=("Device self-test log contains errors") ;;
            esac
        fi
    done

    # If any errors detected
    if [ ${#error_bits[@]} -gt 0 ]; then
        overall_status=1
        detailed_report+="Drive $drive Errors:\n"
        for error in "${error_bits[@]}"; do
            detailed_report+="- $error\n"
        done
    fi
done

# Send notification if any errors found
if [ $overall_status -ne 0 ]; then
    send_notification "SMART Health Issues Detected:\n$detailed_report"
fi
