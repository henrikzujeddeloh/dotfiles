#!/bin/bash

# UUID of backup disk for photos
UUID_PHOTOS=
# UUID of backup disk for nextcloud
UUID_NEXTCLOUD=aac17f78-c550-4986-990a-97e5c33c460b

# source neutron environment variables
source $HOME/dotfiles/scripts/neutron/.env

# define the date
export DATE=$(date +%Y%m%d)

# check if photos backup disk is connected
if lsblk -f | grep -wq $UUID_PHOTOS; then

    echo "Photos offline backup disk detected."
    mkdir -p /tmp/offline_backup

    echo "Mounting external disk"
    sudo mount /dev/disk/by-uuid/${UUID_PHOTOS} /tmp/offline_backup

    echo "Backing up photos to disk"
    borg create --stats --verbose --progress /tmp/offline_backup/photos::$DATE $PATH_TO_DATA/Photos

    echo "Unmounting disk"
    sudo umount /tmp/offline_backup

    echo "Done"
fi

# check if nextcloud backup disk is connected
if lsblk -f | grep -wq $UUID_NEXTCLOUD; then

    echo "Nextcloud offline backup disk detected."
    mkdir -p /tmp/offline_backup

    echo "Mounting external disk"
    sudo mount /dev/disk/by-uuid/${UUID_NEXTCLOUD} /tmp/offline_backup

    echo "Backing up Nextcloud files to disk"
    borg create --stats --verbose --progress /tmp/offline_backup/nextcloud::$DATE $PATH_TO_DATA/Nextcloud/henrik/files $PATH_TO_DATA/Nextcloud/josina/files

    echo "Unmounting disk"
    sudo umount /tmp/offline_backup

    echo "Done"
fi
