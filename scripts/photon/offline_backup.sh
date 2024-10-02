#!/bin/bash

export DOCUMENTS_REPO=/Volumes/OFFLINE_01/backup
export PHOTOS_REPO=/Volumes/OFFLINE_02/backup
export DATE=$(date +%Y%m%d)

input="$1"

# automatic borg repo detection
if [ -d "$DOCUMENTS_REPO" ]; then
    echo "Found borg backup archive: $DOCUMENTS_REPO! Backing up documents to it."
    borg create --stats --verbose --progress --compression zlib,9 $DOCUMENTS_REPO::$DATE-documents $HOME/Cloud/
fi

if [ -d "$PHOTOS_REPO" ]; then
    echo "Found borg backup archive: $PHOTOS_REPO! Backing up photos to it."
    borg create --stats --verbose --progress --compression zlib,9 $PHOTOS_REPO::$DATE-photos /Volumes/Photos/
fi

# prune backups
if [ $input = "prune" ]; then
    echo "Pruning backups of connected backup drives"
    if [ -d "$DOCUMENTS_REPO" ]; then
        echo "Found borg backup archive: $DOCUMENTS_REPO! Pruning very old backups"
        borg prune --list --stats --keep-monthly 12 --keep-yearly 10 $DOCUMENTS_REPO
    fi

    if [ -d "$PHOTOS_REPO" ]; then
        echo "Found borg backup archive: $PHOTOS_REPO! Pruning very old backups"
        borg prune --list --stats --keep-monthly 12 --keep-yearly 10 $PHOTOS_REPO
    fi

fi
