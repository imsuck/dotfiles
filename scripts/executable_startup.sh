#!/usr/bin/env sh

sleep 1

dex --autostart --environment i3 &

eww daemon &

dunst --config ~/.config/dunst/dunstrc &

# $(sleep 30; ~/scripts/mouseless-notif.sh) &

waypaper --restore &

picom &

systemctl --user start opentabletdriver.service &

# systemctl --user start fcitx5-daemon.service &

systemctl --user start mouseless.service &

warp-taskbar &

copyq &

keepassxc &

kdeconnect-indicator &

(cd ~/Applications/arrpc && pnpm start) &

i3-resurrect restore -S main &
