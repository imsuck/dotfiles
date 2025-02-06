#!/usr/bin/env sh

send_notification() {
	brightness=$(printf "%.0f\n" "$(brillo -G)")
	dunstify -u low -r 9991 -h int:value:"$brightness" -i "sun" "Brightness: $brightness%" -t 2000
}

case $1 in
up)
	brillo -A 2.5 -p
	send_notification "$1"
	;;
down)
	brillo -U 2.5 -p
	send_notification "$1"
	;;
esac
