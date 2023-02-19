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
time_icon="$(tmux_get '@tmux_power_time_icon' ' ')"
date_icon="$(tmux_get '@tmux_power_date_icon' ' ')"
prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)
time_format=$(tmux_get @tmux_power_time_format '%R')
date_format=$(tmux_get @tmux_power_date_format '%m-%d')

FG="#C0CAF5"
BG1="black"
BG2="blue"

primary="blue"

tmux_set status on

# Basic status bar colors
tmux_set status-fg "$FG"
tmux_set status-bg "$BG1"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$BG1"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$primary,bg=$BG1,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$primary]#[bg=$BG1]#[fg=$BG1]#[bg=$primary]"
tmux_set @prefix_highlight_output_suffix "#[fg=$primary]#[bg=$BG1]"


# Left side of status bar
# tmux_set status-left-length 150
LS="#[fg=$BG1,bg=$primary] #S #[bg=$BG1] "
LS="$LS#[fg=$primary,bg=$BG1]$right_arrow_icon"

tmux_set status-left "$LS"

# Right side of status bar
tmux_set status-right-length 150
RS=" #{prefix_highlight} "
RS="$RS#[fg=$BG2]$left_arrow_icon#[fg=$BG1,bg=$primary]$time_icon$time_format"
RS="$RS#[fg=$primary,bg=$BG2]$left_arrow_icon#[fg=$BG1,bg=$primary]$date_icon$date_format "

tmux_set status-right "$RS"


# Window status
tmux_set window-status-format " #I:#W#F "
tmux_set window-status-current-format "#[fg=$BG1,bg=$primary]$right_arrow_icon#[fg=$BG1] #I:#W#F #[fg=$BG2,bg=$BG1,nobold]$right_arrow_icon"
tmux_set window-status-separator ""

# Pane border
tmux_set pane-border-style "fg=white"

# Active pane border
tmux_set pane-active-border-style "fg=green"

# Clock
tmux_set clock-mode-colour "$primary"
tmux_set clock-mode-style 24

# Command message
tmux_set message-command-style "fg=default,bg=$BG1"
tmux_set message-style "fg=default,bg=$BG1"

# Copy mode highlight
tmux_set mode-style "bg=$primary,fg=$FG"
