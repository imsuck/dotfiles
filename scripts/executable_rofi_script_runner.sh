#!/usr/bin/env sh

selected=$(ls ~/scripts/ | rofi -theme ~/.config/rofi/rasi/list.rasi -dmenu)

bash -c ~/scripts/$selected
