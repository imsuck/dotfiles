#!/usr/bin/env sh

if [ "$(lsusb --verbose 2>/dev/null | rg -c "2 Mouse")" != \
     "$(lsusb --verbose 2>/dev/null | rg -c "1 Keyboard")" ];
then
    synclient TouchPadOff="1"
else
    synclient TouchPadOff="0"
fi
