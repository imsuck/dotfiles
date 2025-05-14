#!/usr/bin/env bash

tmux_get() {
	local value="$(tmux show -gqv "$1")"
	[ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
	tmux set-option -gq "$1" "$2"
}

# right_arrow_icon=$(tmux_get '@tmux_power_right_arrow_icon' '')
# left_arrow_icon=$(tmux_get '@tmux_power_left_arrow_icon' '')
# time_icon="$(tmux_get '@tmux_power_time_icon' ' ')"
# date_icon="$(tmux_get '@tmux_power_date_icon' '')"
# prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)
time_format=$(tmux_get @tmux_power_time_format '%R')
# date_format=$(tmux_get @tmux_power_date_format '')

grey1="#414868"
grey2="#a9b1d6"
black="#1d202f"
blue="#7aa2f7"
cyan="#7dcfff"
green="#9ece6a"
magenta="#bb9af7"
red="#f7768e"
white="#c0caf5"
yellow="#e0af68"

fg="#c0caf5"
bg="#24283b"
sel_bg="#373d5a"

primary="$blue"
secondary="$yellow"

tmux_set status on

# Basic status bar colors
tmux_set status-fg "$fg"
tmux_set status-bg "$bg"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$bg"
tmux_set @prefix_highlight_bg "$primary"
# tmux_set @prefix_highlight_show_copy_mode 'on'
# tmux_set @prefix_highlight_copy_mode_attr "fg=$primary,bg=$BG1,bold"


# Left side of status bar
tmux_set status-left-length 150
LS="#[fg=$black,bg=$magenta] #S #[default] "

# Right side of status bar
tmux_set status-right-length 150
RS=" #{prefix_highlight}#[default] "
RS="$RS#[fg=default,bg=$black] $time_format #[bg=$yellow] #[default]"


# Window status
tmux_set window-status-format "#[fg=default,bg=$grey1] #I #[fg=default,bg=$black] #W #[default]"
tmux_set window-status-current-format "#[fg=$black,bg=$primary] #I #[fg=default,bg=$black] #W #[default]"
# tmux_set window-status-separator ""

# Pane border
tmux_set pane-border-style "fg=$grey1"
tmux_set pane-active-border-style "fg=$blue"

# Clock
# tmux_set clock-mode-colour "$primary"
# tmux_set clock-mode-style 24

# Command message
tmux_set message-command-style "bg=$black"
tmux_set message-style "bg=$black"

# Copy mode highlight
tmux_set mode-style "fg=default,bg=$sel_bg"

tmux_set status-left "$LS"
tmux_set status-right "$RS"
