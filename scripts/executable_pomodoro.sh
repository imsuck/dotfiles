#!/usr/bin/env sh

CARGO_HOME=~/.local/share/cargo

read -p "Pomodoro length? " len
case $len in
  [Ss]*) $CARGO_HOME/bin/porsmo pomodoro short;;
  [Ll]*) $CARGO_HOME/bin/porsmo pomodoro long;;
esac
