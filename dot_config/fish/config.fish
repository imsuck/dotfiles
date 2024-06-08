set BROWSER firefox
set EDITOR helix
set PAGER bat
export NNN_PLUG="p:preview-tui"
export NNN_FIFO="/tmp/nnn.fifo"
export CARGO_HOME="$HOME/.local/share/cargo"
set PATH $CARGO_HOME/bin $PATH
set RUSTC_WRAPPER sccache
# Vietnamese thing
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

if command -v helix > /dev/null
    abbr -a hx helix
    abbr -a e helix
else if command -v hx > /dev/null
    abbr -a helix hx
    abbr -a e hx
end

abbr -a ... ../../
abbr -a .... ../../../
abbr -a ..... ../../../../
abbr -a yr 'cal -y'
abbr -a ze zellij
abbr -a c cargo
abbr -a m make
abbr -a o handlr open
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
    if test -d ~/dev/others/base16/templates/fish-shell
        set fish_function_path $fish_function_path ~/dev/others/base16/templates/fish-shell/functions
        builtin source ~/dev/others/base16/templates/fish-shell/conf.d/base16.fish
    end

    # tab size
    tabs 4

    # if ! set -q TMUX
    #     exec tmux
    # end
    # if ! set -q ZELLIJ
    #     exec zellij
    # end
end

if command -v aurman > /dev/null
    abbr -a p 'aurman'
    abbr -a up 'aurman -Syu'
else
    abbr -a p 'sudo pacman'
    abbr -a up 'sudo pacman -Syu'
end

if command -v exa > /dev/null
    abbr -a l 'exa --icons'
    abbr -a ls 'exa --icons'
    abbr -a ll 'exa -l --icons'
    abbr -a lll 'exa -la --icons'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Type d to move up to top parent dir which is a repository
function d
    while test $PWD != "/"
        if test -d .git
            break
        end
        cd ..
    end
end

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
    bind \cz 'fg&>/dev/null; echo; fish_prompt'
    bind \e\[3\;5~ kill-word
    bind \e\[3\;3~ kill-word
    bind \el "echo; exa --icons; fish_prompt"
    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end

function fish_greeting
    echo
    echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
    # echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e " \\e[1mDisk usage:\\e[0m"
    echo
    echo -ne (\
        df -l -h | grep -E 'dev/(xvda|sd|mapper)' | \
        awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
        sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
        paste -sd ''\
    )
    echo

    # echo -e " \\e[1mNetwork:\\e[0m"
    # echo
    # # http://tdt.rocks/linux_network_interface_naming.html
    # echo -ne (\
    #     ip addr show up scope global | \
    #         grep -E ': <|inet' | \
    #         sed \
    #             -e 's/^[[:digit:]]\+: //' \
    #             -e 's/: <.*//' \
    #             -e 's/.*inet[[:digit:]]* //' \
    #             -e 's/\/.*//'| \
    #         awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
    #         sort | \
    #         column -t -R1 | \
    #         # public addresses are underlined for visibility \
    #         sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
    #         # private addresses are not \
    #         sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
    #         # unknown interfaces are cyan \
    #         sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
    #         # ethernet interfaces are normal \
    #         sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
    #         # wireless interfaces are purple \
    #         sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
    #         # wwan interfaces are yellow \
    #         sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
    #         sed 's/$/\\\e[0m/' | \
    #         sed 's/^/\t/' \
    #     )
    # echo

    set r (random 0 100)
    if [ $r -lt 5 ] # only occasionally show backlog (5%)
        echo -e " \e[1mBacklog\e[0;32m"
        set_color blue
        echo "  [project] <description>"
        echo
    end

    # set_color normal
    # echo -e " \e[1mTODOs\e[0;32m"
    # echo
    # if [ $r -lt 10 ]
    #         # unimportant, so show rarely
    #     set_color cyan
    #     # echo "  [project] <description>"
    # end
    # if [ $r -lt 25 ]
    #     # back-of-my-mind, so show occasionally
    #     set_color green
    #     # echo "  [project] <description>"
    # end
    # if [ $r -lt 50 ]
    #     # upcoming, so prompt regularly
    #     set_color yellow
    #     # echo "  [project] <description>"
    # end

    # # urgent, so prompt always
    # set_color red
    # # echo "  [project] <description>"

    # echo

    # if test -s ~/todo
    #     set_color magenta
    #     cat todo | sed 's/^/ /'
    #     echo
    # end

    # set_color normal
end

starship init fish | source

# thefuck --alias | source
zoxide init fish | source
