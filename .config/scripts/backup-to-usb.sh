#!/usr/bin/env bash
set -e

USB_MOUNT="/mnt/usb"
LOGFILE="$HOME/backup-usb.log"

echo "==> Starting backup at $(date)" | tee -a "$LOGFILE"

# Check if USB is mounted
if ! mountpoint -q "$USB_MOUNT"; then
    echo "USB not mounted at $USB_MOUNT" | tee -a "$LOGFILE"
    notify-send "❌ USB Backup" "USB not mounted at $USB_MOUNT"
    exit 1
fi

# Rsync configs and package lists
rsync -avh --delete \
    ~/.config \
    ~/.scripts \
    ~/pkglist.txt \
    ~/aurlist.txt \
    ~/flatpaklist.txt \
    "$USB_MOUNT/" | tee -a "$LOGFILE"

echo "==> Backup finished at $(date)" | tee -a "$LOGFILE"
notify-send "✅ USB Backup" "Configs and package lists synced to USB"
