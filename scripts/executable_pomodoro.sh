#!/usr/bin/env sh

read -p "Pomodoro length? " len
case $len in
  [Ss]*) porsmo pomodoro short;;
  [Ll]*) porsmo pomodoro long;;
esac
