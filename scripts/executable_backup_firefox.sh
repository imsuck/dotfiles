#!/usr/bin/env sh
# backs up firefox tabs

SUFFIX=$(date +%Y-%m-%d_%H-%M-%S)
FF_PROFILE="$HOME/.config/floorp/frcmeabr.default-default"
BACKUP_DIR="$HOME/backups/firefox"
cp "$FF_PROFILE/sessionstore-backups/recovery.jsonlz4" \
  "$BACKUP_DIR/firefox-tabs-$SUFFIX.jsonlz4"

# delete backups older than 7 days
fd . "$BACKUP_DIR" --changed-before 7d -ax rm {}
fd . "$HOME/Downloads/backup-tabsessionmanager" --exclude "User Save" --changed-before 7d -ax rm {}
