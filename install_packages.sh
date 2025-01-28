#!/usr/bin/sh

# use `#package` when needed to remove undesired packages
#
# helix macro: "mi<S-W>ms`<A-;>;a#<esc>"
# helix macro to undo: "md`<S-F>#;d"
# Use `"@y` to yank macro ok

sudo pacman -S --noconfirm --needed \
 alacritty wezterm starship `#dunst` github-cli fzf zellij\
 eza ripgrep fd bat zoxide handlr git-delta\
 htop bottom\
 firefox nitrogen\
 polybar rofi rofi-emoji\
 xclip shotgun hacksaw `# screenshot`\
 ttf-fira-code ttf-font-awesome ttf-hack `#otf-ipafont` ttf-iosevka-nerd ttf-roboto-mono\
 rustup rust-analyzer bacon `# rust dev things`\
 cronie stalonetray xdo ranger\
 picom
 # thefuck

yay -S --answerclean All --answerdiff None \
 vesktop\
 eww\
 spotify-adblock-git `#cava`\
 nerd-fonts-hack betterlockscreen\
 ksuperkey kanata autotiling\
 `#nerd-fonts-jetbrains-mono` ttf-icomoon-feather ttf-twemoji\
 `#diskonaut` polybar-spotify-module

systemctl --user enable spotify-listener
systemctl --user start spotify-listener
