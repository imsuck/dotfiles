#!/usr/bin/fish

sudo pacman -S --noconfirm --needed \
 alacritty wezterm starship helix dunst github-cli fzf\
 # rust utilities
 exa ripgrep fd bat zoxide\
 htop bottom\
 discord opera nitrogen\
 polybar rofi\
 xclip shotgun hacksaw\
 ttf-fira-code ttf-font-awesome ttf-hack otf-ipafont ttf-iosevka-nerd ttf-roboto-mono\
 xf86-input-synaptics\
 rust rust-analyzer bacon\
 cronie stalonetray xdo ranger\
 zellij #\
 # thefuck
 # picom

yay -S --answerclean All --answerdiff None \
 discocss-git\
 opera-ffmpeg-codecs eww\
 spotify-adblock-git cava\
 nerd-fonts-hack betterlockscreen\
 ksuperkey autotiling\
 nerd-fonts-jetbrains-mono ttf-icomoon-feather\
 ksuperkey diskonaut polybar-git picom-git polybar-spotify-module

# yay -S zathura zathura-pdf-poppler
 
systemctl --user enable spotify-listener
systemctl --user start spotify-listener
