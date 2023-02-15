#!/usr/bin/env sh

history() {
  cat ~/.local/share/zathura/history |
  rg -Po '\[\K[^\]]*' |
  rg '\.' |
  sed 's/\/home\/\w*/~/' |
  rofi -dmenu -i -config ~/.config/rofi/rasi/list.rasi |
  sed 's/^/\"/;s/$/\"/' |
  xargs zathura
}

search() {
  fd '\.pdf$' ~ |
  sed 's/\/home\/\w*/~/' |
  rofi -dmenu -i -config ~/.config/rofi/rasi/list.rasi |
  sed 's/^/\"/;s/$/\"/' |
  xargs zathura
}

if [[ "$1" == "history" ]]; then
  history
elif [[ "$1" == "search" ]]; then
  search
fi
