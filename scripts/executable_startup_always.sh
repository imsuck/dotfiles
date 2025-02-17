#!/usr/bin/env sh

# Start polybar
~/scripts/polybar.sh

# Start eww bar
# eww open bar

# Disable touchpad if there is a USB mouse plugged in
~/scripts/touchpad.sh

killall ksuperkey
ksuperkey -t 250 -e "Super_L=Shift_L|F9" &

# activate-linux &

# Don't turn screen off automatically
xset s off -dpms &

# killall xbanish
# xbanish -i all &
killall unclutter
unclutter --timeout 5 -b

killall autotiling
autotiling &
