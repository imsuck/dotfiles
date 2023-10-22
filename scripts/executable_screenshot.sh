#!/usr/bin/env sh

selection=$(hacksaw)
name="$HOME/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
shotgun -g "$selection" - > $name
xclip -t "image/png" -selection clipboard $name
