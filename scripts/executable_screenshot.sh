#!/usr/bin/env sh

selection=$(hacksaw) || exit 1
name="$HOME/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
shotgun -g "$selection" - > $name
xclip -t "image/png" -selection clipboard $name
