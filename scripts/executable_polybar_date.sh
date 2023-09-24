#!/usr/bin/env sh

t=0
sleep_pid=0

toggle() {
    t=$((1 - t))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}


trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        echo " $(date +%H:%M)"
    else
        echo "󰃭 $(date +%d-%m)"
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
