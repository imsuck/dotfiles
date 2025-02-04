set BROWSER firefox
set PAGER bat
export NNN_PLUG="p:preview-tui"
export NNN_FIFO="/tmp/nnn.fifo"
export CARGO_HOME="$HOME/.local/share/cargo"
set PATH $CARGO_HOME/bin $HOME/.local/bin $HOME/.nix-profile/bin $PATH
set RUSTC_WRAPPER sccache
# Setup ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

if command -v helix >/dev/null
    set EDITOR helix
    abbr -a hx helix
    abbr -a e helix
else if command -v hx >/dev/null
    set EDITOR hx
    abbr -a helix hx
    abbr -a e hx
end

alias sudoedit "sudo -E (which $EDITOR)"
abbr -a ... ../../
abbr -a .... ../../../
abbr -a ..... ../../../../
abbr -a yr 'cal -y'
abbr -a ze zellij
abbr -a c cargo
abbr -a m make
abbr -a o handlr open
abbr -a yz yazi
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a ct 'cargo t'
# abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
# abbr -a ks 'keybase chat send'
# abbr -a kr 'keybase chat read'
# abbr -a kl 'keybase chat list'
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'
abbr -a wtr 'curl "wttr.in/?qF"'
abbr -a fetchimg 'neofetch --iterm2 --source ~/backgrounds/74016100_p0.png --crop_mode fill --size 200'
abbr -a ltop 'watch -c -n 0.01667 "df; printf \'\\n\'; free -m; printf \'\\n\'; mpstat"'
abbr -a df 'duf -theme ansi'

if status --is-interactive
    # tab size
    tabs 4

    starship init fish | source
    functions --copy fish_prompt _fish_prompt
    function fish_prompt
        printf "\e[0 q" # reset cursor
        _fish_prompt
    end

    # thefuck --alias | source
    zoxide init fish | source

    # if ! set -q TMUX
    #     exec tmux
    # end
    # if ! set -q ZELLIJ
    #     exec zellij
    # end
end

if command -v aurman >/dev/null
    abbr -a p aurman
    abbr -a up 'aurman -Syu'
else
    abbr -a p 'sudo pacman'
    abbr -a up 'sudo pacman -Syu'
end

if command -v exa >/dev/null
    abbr -a l 'exa --icons'
    abbr -a ls 'exa --icons'
    abbr -a ll 'exa -l --icons'
    abbr -a lll 'exa -la --icons'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Type d to move up to top parent dir which is a repository
function d
    while test $PWD != /
        if test -d .git
            break
        end
        cd ..
    end
end

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m' # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
setenv LESS_TERMCAP_me \e'[0m' # end mode
setenv LESS_TERMCAP_se \e'[0m' # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m' # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD cat

function fish_user_key_bindings
    bind \cz 'fg&>/dev/null; echo; fish_prompt'
    bind \e\[3\;5~ kill-word
    bind \e\[3\;3~ kill-word
    bind \el "echo; exa --icons; fish_prompt"
    bind \cl "clear -x; printf '\e[6 q'; fish_prompt"
    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end

function fish_greeting
end

# disable pkgfile searching
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

# Created by `pipx` on 2024-11-06 13:48:05
set PATH $PATH /home/imsuck/.local/bin

bass source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
