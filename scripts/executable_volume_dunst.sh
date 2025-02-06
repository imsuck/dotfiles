#!/usr/bin/env sh

send_notification() {
	volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
	notify-send -u low -r 9993 -h int:value:"$volume" -i "volume-$1" "Volume: ${volume}" -t 2000
}

case $1 in
up)
	amixer --quiet -D pulse sset Master unmute
	amixer --quiet -D pulse sset Master 5%+
	send_notification "$1"
	;;
down)
	amixer --quiet -D pulse sset Master unmute
	amixer --quiet -D pulse sset Master 5%-
	send_notification "$1"
	;;
mute)
	amixer --quiet -D pulse sset Master toggle
	if [[ -z "$(amixer -D pulse get Master | rg '\[on\]')" ]]; then
		dunstify -a "changevolume" -t 2000 -r 9993 -u low -i "volume-mute" "Muted"
	else
		send_notification up
	fi
	;;
esac
