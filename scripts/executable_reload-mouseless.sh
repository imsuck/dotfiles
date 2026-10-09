#!/usr/bin/env sh

sudo systemctl -M imsuck@ --user restart mouseless.service

sleep 3

xmodmap -e 'keycode 94 = Shift_L'
