#!/usr/bin/env sh

dex --autostart --environment i3

eww daemon &

wezterm &

# thunar &

opera %U &

dbus-launch dunst --config ~/.config/dunst/dunstrc &

sleep 2 && nitrogen --restore &

sleep 2 && picom -b &
