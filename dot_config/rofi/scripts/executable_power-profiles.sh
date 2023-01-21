#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Quick Links

# Import Current Theme
theme="$HOME"/.config/rofi/rasi/applets.rasi

# Theme Elements
prompt='Power Profiles'
mesg=""

efonts="JetBrains Mono Nerd Font 28"

list_col='4'
list_row='1'

# Options
option_1=""
option_2=""
option_3=""
option_4=""

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-markup-rows \
		-theme $theme
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		powerprofilesctl set performance
	elif [[ "$1" == '--opt2' ]]; then
		powerprofilesctl set balanced
	elif [[ "$1" == '--opt3' ]]; then
		powerprofilesctl set power-saver
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
  $option_1)
	run_cmd --opt1
    ;;
  $option_2)
	run_cmd --opt2
    ;;
  $option_3)
	run_cmd --opt3
    ;;
  $option_4)
	run_cmd --opt4
    ;;
esac
