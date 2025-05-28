#!/usr/bin/env bash

sudo_main() {
  echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video \$sys\$devpath/brightness", RUN+="/bin/chmod g+w \$sys\$devpath/brightness"' |\
    tee /etc/udev/rules.d/backlight.rules

  echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="25a7", ATTRS{idProduct}=="fa70", RUN+="/home/imsuck/scripts/reload-mouseless.sh"' |\
    tee /etc/udev/rules.d/mouseless.rules

  echo 'KERNEL=="uinput", GROUP="imsuck", MODE:="0660"'                | tee /etc/udev/rules.d/99-imsuck.rules
  echo 'KERNEL=="event*", GROUP="imsuck", NAME="input/%k", MODE="660"' | tee -a /etc/udev/rules.d/99-imsuck.rules

	echo 'Section "InputClass"'                    | tee /etc/X11/xorg.conf.d/40-libinput.conf
	echo ' Identifier "libinput pointer catchall"' | tee -a /etc/X11/xorg.conf.d/40-libinput.conf
	echo ' MatchIsPointer "on"'                    | tee -a /etc/X11/xorg.conf.d/40-libinput.conf
	echo ' MatchDevicePath "/dev/input/event*"'    | tee -a /etc/X11/xorg.conf.d/40-libinput.conf
	echo ' Driver "libinput"'                      | tee -a /etc/X11/xorg.conf.d/40-libinput.conf
	echo ' Option "AccelProfile" "flat"'           | tee -a /etc/X11/xorg.conf.d/40-libinput.conf
	echo 'EndSection'                              | tee -a /etc/X11/xorg.conf.d/40-libinput.conf

	# I don't use kitty anyway
	ln -s /usr/share/terminfo/x/xterm-256color /usr/share/x/xterm-kitty
}

main() {
  ln -s /usr/bin/helix ~/.local/bin/hx
}

main
SUDO_MAIN=$(declare -f sudo_main)
sudo bash -c "$SUDO_MAIN; sudo_main"
