#!/usr/bin/env sh
# backs up firefox tabs

SUFFIX=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="$HOME/backups/firefox"
cp "$HOME/.mozilla/firefox/imsuck/sessionstore-backups/recovery.jsonlz4" \
  "$BACKUP_DIR/firefox-tabs-$SUFFIX.jsonlz4"

# delete backups older than 30 days
fd . "$BACKUP_DIR" --changed-before 30d -ax rm {}
