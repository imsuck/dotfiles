#!/usr/bin/env fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/1f0dc2b4970da160605638cb0f157079660d6e04/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install edc/bass
fisher install jorgebucaran/autopair.fish

# yazi plugins, don't ask why I put it here
ya pack -u
