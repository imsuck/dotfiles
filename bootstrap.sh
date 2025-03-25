#!/usr/bin/env bash

main() {
  echo '%wheel ALL = NOPASSWD:/usr/bin/mouseless' | tee /etc/sudoers.d/10-mouseless
  echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video \$sys\$devpath/brightness", RUN+="/bin/chmod g+w \$sys\$devpath/brightness"'\
    tee /etc/udev/rules.d/backlight.rules
}

MAIN=$(declare -f main)
sudo bash -c "$MAIN; main"
