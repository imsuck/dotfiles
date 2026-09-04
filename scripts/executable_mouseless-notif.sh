#!/usr/bin/env sh

PIDFILE="/tmp/mouseless-watchexec.pid"
STATEFILE="/var/tmp/mouseless.state"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  kill "$(cat "$PIDFILE")"
  rm -f "$PIDFILE"
fi

case "${XDG_CURRENT_DESKTOP:-}" in
  *KDE*|*kde*|*PLASMA*|*plasma*)
    NOTIFY_CMD='notify-send -t 500 "$(cat /var/tmp/mouseless.state)"'
    ;;
  *)
    NOTIFY_CMD='notify-send -r 32835 -t 500 "$(cat /var/tmp/mouseless.state)"'
    ;;
esac

watchexec -pw "$STATEFILE" "$NOTIFY_CMD" &

echo $! > "$PIDFILE"

while true; do
  sleep 86400
done
