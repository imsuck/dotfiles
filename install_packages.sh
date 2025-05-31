#!/usr/bin/env sh

# use `#package` when needed to remove undesired packages
#
# helix macro: "mi<S-W>ms`<A-;>;a#<esc>"
# helix macro to undo: "md`<S-F>#;d"
# Use `"@y` to yank macro ok

alias pac_inst='sudo pacman -S --noconfirm --needed'

pac_inst cronie

pac_inst atuin bat bat-extras dust eza fd fzf ripdrag starship vivid yazi zoxide \
  impala
# dev
pac_inst clang helix mise tinymist typst watchexec zellij
# rust dev
pac_inst rustup rust-analyzer bacon sccache

pac_inst alacritty bottom handlr wezterm
pac_inst firefox nitrogen picom polybar qalculate-gtk rofi rofi-emoji zathura

# screenshot
pac_inst xclip shotgun hacksaw

pac_inst xdo clipcat `#cronie` `#stalonetray`
pac_inst fcitx5-bamboo fcitx5-mozc-ut ibus # needed for fcitx5 (???)

yay -S --needed --answerclean All --answerdiff None \
  autotiling ksuperkey \
  vesktop \
  eww \
  spotify-adblock-git `#cava` \
  betterlockscreen pavucontrol-gtk3 networkmanager-iwd \
  `#nerd-fonts-jetbrains-mono` \
  typstyle `#diskonaut` polybar-spotify-module

systemctl --user enable spotify-listener
systemctl --user start spotify-listener

./plugins.fish
