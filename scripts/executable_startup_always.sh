#!/usr/bin/env sh

# Disable mouse acceleration
~/scripts/mouse.sh

# Start polybar
~/scripts/polybar.sh

# Start eww bar
# eww open bar

# Disable touchpad if there is a USB mouse plugged in
~/scripts/touchpad.sh

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=F9' &
ksuperkey -e 'Super_R=F9' &

# activate-linux &

# Don't turn screen off automatically
xset s off -dpms &
