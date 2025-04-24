#!/usr/bin/sh

# use `#package` when needed to remove undesired packages
#
# helix macro: "mi<S-W>ms`<A-;>;a#<esc>"
# helix macro to undo: "md`<S-F>#;d"
# Use `"@y` to yank macro ok

sudo pacman -S --noconfirm --needed \
 alacritty wezterm `#dunst` fzf \
 firefox nitrogen \
 xclip shotgun hacksaw `# screenshot` \
 rustup rust-analyzer `# rust dev things` \
 cronie `#stalonetray` xdo `#ranger` \
 fcitx5-bamboo fcitx5-mozc-ut ibus `# needed for fcitx5 (???)` \
 polybar picom rofi rofi-emoji
 # thefuck

yay -S --answerclean All --answerdiff None \
 vesktop \
 eww \
 spotify-adblock-git `#cava` \
 betterlockscreen pavucontrol-gtk3 \
 `#nerd-fonts-jetbrains-mono` \
 `#diskonaut` polybar-spotify-module

systemctl --user enable spotify-listener
systemctl --user start spotify-listener
