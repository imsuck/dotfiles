#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# Current Theme
dir="$HOME/.config/rofi/rasi/powermenu.rasi"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host="$(hostname)"

# Options
shutdown='shutdown'
reboot='reboot'
lock='lock'
sleep='sleep'
hibernate='hibernate'
logout='logout'
yes=''
no=''

# Display error notification using notify-send or rofi fallback
show_error() {
  local msg="$1"
  if command -v notify-send &>/dev/null; then
    notify-send -u critical "Power Menu" "$msg"
  else
    rofi -theme "$dir" -e "$msg"
  fi
}

# Check if hibernation is supported and has sufficient swap space
can_hibernate() {
  # 1. Check kernel support
  if ! grep -q -w "disk" /sys/power/state 2>/dev/null; then
    echo "Kernel does not support hibernation."
    return 1
  fi

  # 2. Check if a resume device/offset is configured in kernel parameters
  local resume_dev
  resume_dev="$(cat /sys/power/resume 2>/dev/null)"
  if [[ -z "$resume_dev" || "$resume_dev" == "0:0" ]]; then
    echo "No resume partition configured in kernel parameters."
    return 1
  fi

  # 3. Read memory and swap values from /proc/meminfo (in kB)
  local mem_total mem_avail swap_free mem_used
  mem_total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo 2>/dev/null)
  mem_avail=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo 2>/dev/null)
  swap_free=$(awk '/^SwapFree:/ {print $2}' /proc/meminfo 2>/dev/null)

  if [[ -z "$mem_total" || -z "$swap_free" || -z "$mem_avail" ]]; then
    echo "Unable to read memory state from /proc/meminfo."
    return 1
  fi

  if (( swap_free == 0 )); then
    echo "No active swap space available."
    return 1
  fi

  # Active RAM currently in use that needs to be written to swap
  mem_used=$((mem_total - mem_avail))

  # Compare available swap to active RAM usage
  if (( swap_free < mem_used )); then
    local missing_mb=$(( (mem_used - swap_free) / 1024 ))
    echo "Insufficient swap space (short by ~${missing_mb} MB)."
    return 1
  fi

  return 0
}

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -theme-str "entry { placeholder: \"$host - $uptime\"; }"
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme "$dir"
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$sleep\n$hibernate\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

save_sess() {
  rm -rf ~/.local/state/i3-resurrect/sessions/main/
  i3-resurrect save -S main
  sleep 1
}

# Execute Command
run_cmd() {
  # selected="$(confirm_exit)"
  selected="$yes"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      save_sess
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      save_sess
      systemctl reboot
    elif [[ $1 == '--sleep' ]]; then
      systemctl suspend
      betterlockscreen -l
    elif [[ $1 == '--hibernate' ]]; then
      local err_msg
      err_msg="$(can_hibernate)"
      if [[ $? -eq 0 ]]; then
        systemctl hibernate &
        sleep 3
        betterlockscreen -l
      else
        show_error "Hibernation failed: $err_msg"
      fi
    elif [[ $1 == '--logout' ]]; then
      if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
        openbox --exit
      elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
        bspc quit
      elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
        save_sess
        i3-msg exit
      elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
        qdbus org.kde.ksmserver /KSMServer logout 0 0 0
      fi
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
  $shutdown)
    run_cmd --shutdown
    ;;
  $reboot)
    run_cmd --reboot
    ;;
  $lock)
    if [[ -x '/usr/bin/betterlockscreen' ]]; then
      betterlockscreen -l
    elif [[ -x '/usr/bin/i3lock' ]]; then
      i3lock
    fi
    ;;
  $sleep)
    run_cmd --sleep
    ;;
  $hibernate)
    run_cmd --hibernate
    ;;
  $logout)
    run_cmd --logout
    ;;
esac
