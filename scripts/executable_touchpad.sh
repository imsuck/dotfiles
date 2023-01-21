#!/usr/bin/env sh

if lsusb --verbose 2>&1 | rg -i --quiet "Mouse";
then
    synclient TouchPadOff="1"
fi