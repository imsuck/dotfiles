#!/usr/bin/env sh
# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# For more information about input/output arguments read
# xdg-desktop-portal-termfilechooser(5)

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
debug="$6"

set -e

if [ "$debug" = 1 ]; then
    set -x
fi

cmd="yazi"
termcmd="${TERMCMD:-ghostty --class=filepicker --title='termfilechooser' --command}"

tmp_config=""

if [ "$multiple" != "1" ]; then
    # Create a temporary config that disables multi-selection shortcuts.
    tmp_config=$(mktemp -d)
    trap 'rm -rf "$tmp_config"' EXIT HUP INT TERM

    cat > "$tmp_config/keymap.toml" <<'EOF'
[[mgr.prepend_keymap]]
on = " "
run = "noop"

[[mgr.prepend_keymap]]
on = "v"
run = "noop"

[[mgr.prepend_keymap]]
on = "V"
run = "noop"

[[mgr.prepend_keymap]]
on = "<C-a>"
run = "noop"
EOF

    cmd="env YAZI_CONFIG_HOME=$tmp_config yazi"
fi

if [ "$save" = "1" ]; then
    # Save a file
    set -- --chooser-file="$out" "$path"
elif [ "$directory" = "1" ]; then
    # Upload files from a directory
    set -- --chooser-file="$out" --cwd-file="$out"".1" "$path"
elif [ "$multiple" = "1" ]; then
    # Upload multiple files
    set -- --chooser-file="$out" "$path"
else
    # Upload only 1 file
    set -- --chooser-file="$out" "$path"
fi

command="$termcmd='$cmd"
for arg in "$@"; do
    # Escape double quotes
    escaped=$(printf "%s" "$arg" | sed 's/"/\\"/g')
    # Escape special characters
    command="$command \"$escaped\""
done

command="$command'"

sh -c "$command"

if [ "$directory" = "1" ]; then
    if [ ! -s "$out" ] && [ -s "$out"".1" ]; then
        cat "$out"".1" > "$out"
        rm "$out"".1"
    else
        rm "$out"".1"
    fi
fi
