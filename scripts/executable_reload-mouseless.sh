#!/usr/bin/env sh

su imsuck <<EOF
  export XDG_RUNTIME_DIR=/run/user/$(id -u imsuck)
  export DBUS_SESSION_BUS_ADDRESS=/run/user/$(id -u imsuck)/bus

  systemctl --user restart mouseless.service
EOF
