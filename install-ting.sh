#!/bin/zsh
# TING side, once per TING: copy the engine, chirps and presets to its disk.
# Plug the TING in over USB-C first. Firmware is not touched.
set -e
cd "$(dirname "$0")"
setopt nullglob
DISK=""
for v in "/Volumes/FX MIC DISK" "/Volumes/TINGDISK"; do
  if [ -d "$v" ]; then DISK="$v"; fi
done
if [ -z "$DISK" ]; then echo "TING disk not found. Plug it in over USB-C."; exit 1; fi
BACKUP=~/Documents/ting-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP"
for f in "$DISK"/*.*; do cp -X "$f" "$BACKUP"/; done
echo "Backed up disk to $BACKUP"
cp -X ting-disk/* "$DISK"/
sync
diskutil eject "$DISK"
echo "Unplug, press the button above the USB port, squeeze to start. Then hold a squeeze ~6s once."
