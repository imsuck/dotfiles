#!/usr/bin/env sh
hacksaw=$(hacksaw -f "%x %y %w %h %g %i") || exit 1
curr_date=$(date "+%Y-%m-%d_%H-%M-%S")
read -r X Y W H G ID <<< $hacksaw
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse ~/Videos/recording-$curr_date.mp4
