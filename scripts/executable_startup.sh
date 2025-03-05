#!/usr/bin/env sh

dex --autostart --environment i3

eww daemon &

alacritty &

# thunar &

# firefox &

dbus-launch dunst --config ~/.config/dunst/dunstrc &

nitrogen --restore &

sh -c 'sleep 2; picom' &

systemctl --user start opentabletdriver.service &

systemctl --user start fcitx5-daemon.service &

# xclipboard &
