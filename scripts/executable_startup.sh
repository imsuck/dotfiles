#!/usr/bin/env sh

dex --autostart --environment i3

eww daemon &

alacritty &

# thunar &

firefox &

dbus-launch dunst --config ~/.config/dunst/dunstrc &

nitrogen --restore &

picom &

xclipboard &
