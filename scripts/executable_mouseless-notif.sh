#!/usr/bin/env sh

PIDFILE="/tmp/mouseless-watchexec.pid"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  kill "$(cat "$PIDFILE")"
  rm -f "$PIDFILE"
fi

watchexec -pw /tmp/mouseless.state \
  'notify-send -r 32835 -t 500 "$(cat /tmp/mouseless.state)"' &

echo $! > "$PIDFILE"
