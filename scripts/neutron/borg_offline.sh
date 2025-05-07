#!/bin/bash

# UUID of backup disk for photos
UUID_PHOTOS=aac17f78-c550-4986-990a-97e5c33c460b
# UUID of backup disk for nextcloud
UUID_NEXTCLOUD=acecc26b-717f-4476-8de4-7a4ccebd2954
# UUID of backup disk for immich
UUID_IMMICH=acecc26b-717f-4476-8de4-7a4ccebd2954

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# define the date
export DATE=$(date +%Y%m%d)

# define mount point
MOUNT_POINT=/tmp/offline_backup

# check if photos backup disk is connected
if lsblk -f | grep -wq $UUID_PHOTOS; then

    echo "Photos offline backup disk detected."
    mkdir -p $MOUNT_POINT

    echo "Mounting external disk"
    sudo mount /dev/disk/by-uuid/${UUID_PHOTOS} $MOUNT_POINT

    echo "Backing up photos to disk"
    borg create --stats --verbose --progress $MOUNT_POINT/photos::$DATE $PATH_TO_DATA/Photos
    borg list $MOUNT_POINT/photos

    # Get the total size and used space in blocks
    df_output=$(df --block-size=1G "$MOUNT_POINT" | tail -n 1)
    total_space=$(echo "$df_output" | awk '{print $2}')
    used_space=$(echo "$df_output" | awk '{print $3}')

    # Calculate the free space in GB
    free_space=$((total_space - used_space))

    # Calculate the free percentage
    free_percentage=$((100 - (used_space * 100 / total_space)))

    # Output the result
    echo "Remaining space: $free_percentage% ($free_space GB)" 

    echo "Unmounting disk"
    sudo umount $MOUNT_POINT

    echo "Done"
fi

# check if nextcloud backup disk is connected
if lsblk -f | grep -wq $UUID_NEXTCLOUD; then

    echo "Nextcloud offline backup disk detected."
    mkdir -p $MOUNT_POINT

    echo "Mounting external disk"
    sudo mount /dev/disk/by-uuid/${UUID_NEXTCLOUD} $MOUNT_POINT

    echo "Backing up Nextcloud files to disk"
    borg create --stats --verbose --progress $MOUNT_POINT/nextcloud::$DATE $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files
    borg list $MOUNT_POINT/nextcloud

    # Get the total size and used space in blocks
    df_output=$(df --block-size=1G "$MOUNT_POINT" | tail -n 1)
    total_space=$(echo "$df_output" | awk '{print $2}')
    used_space=$(echo "$df_output" | awk '{print $3}')

    # Calculate the free space in GB
    free_space=$((total_space - used_space))

    # Calculate the free percentage
    free_percentage=$((100 - (used_space * 100 / total_space)))

    # Output the result
    echo "Remaining space: $free_percentage% ($free_space GB)" 

    echo "Unmounting disk"
    sudo umount $MOUNT_POINT

    echo "Done"
fi

# check if immich backup disk is connected
if lsblk -f | grep -wq $UUID_IMMICH; then

    echo "Immich offline backup disk detected."
    mkdir -p $MOUNT_POINT

    echo "Mounting external disk"
    sudo mount /dev/disk/by-uuid/${UUID_IMMICH} $MOUNT_POINT

    echo "Backing up Immich files to disk"
    borg create --stats --verbose --progress $MOUNT_POINT/immich::$DATE $PATH_TO_DATA/Immich/library
    borg list $MOUNT_POINT/immich

    # Get the total size and used space in blocks
    df_output=$(df --block-size=1G "$MOUNT_POINT" | tail -n 1)
    total_space=$(echo "$df_output" | awk '{print $2}')
    used_space=$(echo "$df_output" | awk '{print $3}')

    # Calculate the free space in GB
    free_space=$((total_space - used_space))

    # Calculate the free percentage
    free_percentage=$((100 - (used_space * 100 / total_space)))

    # Output the result
    echo "Remaining space: $free_percentage% ($free_space GB)" 

    echo "Unmounting disk"
    sudo umount $MOUNT_POINT

    echo "Done"
fi
