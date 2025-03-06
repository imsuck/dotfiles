#!/usr/bin/sh

# use `#package` when needed to remove undesired packages
#
# helix macro: "mi<S-W>ms`<A-;>;a#<esc>"
# helix macro to undo: "md`<S-F>#;d"
# Use `"@y` to yank macro ok

sudo pacman -S --noconfirm --needed \
 wezterm `#dunst` fzf \
 firefox\
 xclip shotgun hacksaw `# screenshot`\
 rustup rust-analyzer `# rust dev things`\
 cronie `#stalonetray` xdo `#ranger\`
 ibus `# needed for fcitx5 (???)`
 `#picom`
 # thefuck

yay -S --answerclean All --answerdiff None \
 vesktop\
 eww\
 spotify-adblock-git `#cava`\
 betterlockscreen\
 `#nerd-fonts-jetbrains-mono`\
 `#diskonaut` polybar-spotify-module

systemctl --user enable spotify-listener
systemctl --user start spotify-listener
