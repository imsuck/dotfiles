#!/usr/bin/env sh

dex --autostart --environment i3 &

eww daemon &

dbus-launch dunst --config ~/.config/dunst/dunstrc &

nitrogen --restore &

sh -c 'sleep 2; picom' &

systemctl --user start opentabletdriver.service &

systemctl --user start fcitx5-daemon.service &

systemctl --user start mouseless.service &

clipcatd &
