#!/usr/bin/env sh

# Disable mouse acceleration
~/scripts/mouse.sh

# Start polybar
~/scripts/polybar.sh

# Start eww bar
# eww open bar

# Disable touchpad if there is a USB mouse plugged in
~/scripts/touchpad.sh

# activate-linux &

ibus-daemon -drx

# Don't turn screen off automatically
xset s off -dpms &

# killall xbanish
# xbanish -i all &
killall unclutter
unclutter --timeout 5 -b

killall autotiling
autotiling &
