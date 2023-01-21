#!/usr/bin/env sh

case "$1" in
  *.tar*) tar tf "$1";;
  *.zip) unzip -l  "$1";;
  *.rar) unrar l "$1";;
  *.7z) 7z l "$1";;
  *.pdf) pdftotext "$1" -;;
  *.png|*.jpg|*.gif)
    catimg -w $(echo "$2 * 2" | bc) "$1"
    # img2sixel "$1"
    ;;
  *.mp4) echo "Video";;
  *) bat --color=always --style=base16 --terminal-width=$2 $1;;
esac
