#!/bin/bash

# Source directory (your home folder)
SOURCE_DIR="$HOME/"

# Destination directory (external USB hard drive)
DEST_DIR="/run/media/julien/Julien/backup"


echo "Starting backup of $SOURCE_DIR to $DEST_DIR..."
borg create --progress "$DEST_DIR::archive-{hostname}-{now}" "$SOURCE_DIR" --exclude ".cache"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed. Please check the error messages above."
    exit 1
fi

# Prune old backups (optional)
# This keeps daily backups for the last 7 days, weekly backups for the last 4 weeks,
# and monthly backups for the last 6 months.
echo "Pruning old backups..."
borg prune --keep-daily=3 --keep-weekly=2 --keep-monthly=6 "$DEST_DIR/$REPO_NAME"

if [ $? -eq 0 ]; then
    echo "Pruning completed successfully."
else
    echo "Pruning failed. Please check the error messages above."
    exit 1
fi
