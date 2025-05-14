#!/usr/bin/env sh

selected=$(fd -tf ~/scripts/ | rofi -theme ~/.config/rofi/rasi/list.rasi -dmenu)

bash -c ~/scripts/$selected
