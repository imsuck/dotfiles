#!/usr/bin/sh

# use `#package` when needed to remove undesired packages
#
# helix macro: "mi<S-W>ms`<A-;>;a#<esc>"
# helix macro to undo: "md`<S-F>#;d"
# Use `"@y` to yank macro ok

sudo pacman -S --noconfirm --needed \
 alacritty wezterm starship helix `#dunst` github-cli fzf zellij\
 eza ripgrep fd bat zoxide handlr git-delta `# rust utilities`\
 htop bottom\
 firefox nitrogen\
 `#polybar` rofi\
 xclip shotgun hacksaw `# screenshot`\
 ttf-fira-code ttf-font-awesome ttf-hack `#otf-ipafont` ttf-iosevka-nerd ttf-roboto-mono\
 xf86-input-synaptics\
 rustup rust-analyzer bacon `# rust dev things`\
 cronie stalonetray xdo ranger\
 # thefuck
 # picom

yay -S --answerclean All --answerdiff None \
 vesktop\
 eww\
 spotify-adblock-git `#cava\`
 nerd-fonts-hack betterlockscreen\
 kanata autotiling\
 `#nerd-fonts-jetbrains-mono` ttf-icomoon-feather\
 `#diskonaut` polybar-git picom-git polybar-spotify-module

systemctl --user enable spotify-listener
systemctl --user start spotify-listener
