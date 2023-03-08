#!/usr/bin/env sh

dex --autostart --environment i3

eww daemon &

wezterm &

# thunar &

opera %U &

dbus-launch dunst --config ~/.config/dunst/dunstrc &

nitrogen --restore &

picom &
