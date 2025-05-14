#!/usr/bin/env bash

BAT_LVL=$(cat /sys/class/power_supply/BAT0/capacity)

if (( $BAT_LVL < 25 )); then
  printf '#[fg=$fg,bg=$black] '"$BAT_LVL"'%% #[bg=$red] #[default]'
elif (( $BAT_LVL < 75 )); then
  printf '#[fg=$fg,bg=$black] '"$BAT_LVL"'%% #[bg=$yellow] #[default]'
elif (( $BAT_LVL < 95 )); then
  printf '#[fg=$fg,bg=$black] '"$BAT_LVL"'%% #[bg=$green] #[default]'
fi
