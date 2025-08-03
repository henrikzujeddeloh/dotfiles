#!/usr/bin/env bash

# UUID of backup disk for photos
UUID_PHOTOS=aac17f78-c550-4986-990a-97e5c33c460b
# UUID of backup disk for nextcloud
UUID_NEXTCLOUD=acecc26b-717f-4476-8de4-7a4ccebd2954
# UUID of backup disk for immich
UUID_IMMICH=acecc26b-717f-4476-8de4-7a4ccebd2954

# define the date
archive="$(date +%Y%m%d)"

# define mount point
mount_point="/tmp/offline_backup"

# path to data drives
path_to_data="/srv/data"

perform_backup() {
    local uuid="$1"
    local backup_name="$2"
    local backup_path="$3"
    
    # Check if backup disk is connected
    if ! lsblk -f | grep -wq "$uuid"; then
        echo "Backup disk for $backup_name not detected. Moving on."
        return 0
    fi
    
    # check if borg backup is installed
    if ! [ -x "$(command -v borg)" ]; then
        echo "[ERROR] borg not installed."
        exit 1
    fi
    
    # Prepare mount point
    mkdir -p "$mount_point" || { 
        echo "[ERROR] mount point could not be created at $mount_point"; exit 1; }
    
    # Mount disk
    sudo mount "/dev/disk/by-uuid/${uuid}" "$mount_point" || { echo "[ERROR] disk with uuid $uuid could not be mounted at $mount_point"; sudo umount "$mount_point";  exit 1; }
    
    # Perform backup
    borg create --stats --verbose --progress --list "$mount_point/$backup_name::$archive" "$backup_path" || { echo "[ERROR] could not create backup $archive for $backup_path"; sudo umount "$mount_point"; exit 1; }
    
    borg prune --stats --verbose --list --keep-daily 7 --keep-weekly 4 --keep-monthly 12 "$mount_point/$backup_name" || { echo "[ERROR] could not prune backups"; sudo umount "$mount_point";  exit 1; }

    borg compact "$mount_point/$backup_name" || { echo "[ERROR] could not compact backups"; sudo umount "$mount_point"; exit 1; }

    borg check --verify-data "$mount_point/$backup_name" || { echo "[ERROR] could not check backups"; sudo umount "$mount_point"; exit 1; }
    
    # Get disk space info
    get_disk_space_info "$mount_point"
    
    # Unmount disk
    sudo umount "$mount_point" || { echo "[ERROR] could not unmount disk from $mount_point"; exit 1; }

    echo "[SUCCESS] created backup for $backup_name"
    
}

get_disk_space_info() {
    local mount_path="$1"
    local df_output
    
    df_output=$(df --block-size=1G "$mount_path" | tail -n 1)
    
    local total_space used_space free_space
    total_space=$(echo "$df_output" | awk '{print $2}')
    used_space=$(echo "$df_output" | awk '{print $3}')
    free_space=$((total_space - used_space))
    
    echo "Remaining space: $free_space GB"
}

# Perform backups
perform_backup "$UUID_PHOTOS" "photos" "$path_to_data/Photos"
perform_backup "$UUID_NEXTCLOUD" "nextcloud" "$path_to_data/Nextcloud/henrik/files $path_to_data/Nextcloud/josina/files"
perform_backup "$UUID_IMMICH" "immich" "$path_to_data/Immich/library"
