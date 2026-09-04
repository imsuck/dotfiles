#!/usr/bin/env sh

dex --autostart --environment i3 &

eww daemon &

dunst --config ~/.config/dunst/dunstrc &

# $(sleep 30; ~/scripts/mouseless-notif.sh) &

waypaper --restore &

(sleep 5; picom) &

systemctl --user start opentabletdriver.service &

# systemctl --user start fcitx5-daemon.service &

systemctl --user start mouseless.service &

warp-taskbar &

copyq &

keepassxc &

kdeconnectd &
kdeconnect-indicator

(cd ~/Applications/arrpc && pnpm start) &
