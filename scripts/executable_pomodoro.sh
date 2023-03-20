#!/usr/bin/env sh

read -p "Pomodoro length? " len
case $len in
  [Ss]*) /home/imsuck/.cargo/bin/porsmo pomodoro short;;
  [Ll]*) /home/imsuck/.cargo/bin/porsmo pomodoro long;;
esac