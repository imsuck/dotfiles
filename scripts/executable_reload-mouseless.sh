#!/usr/bin/env sh

sudo systemctl -M imsuck@ --user restart mouseless.service

sleep 1

xmodmap -e 'keycode 94 = Shift_L'
