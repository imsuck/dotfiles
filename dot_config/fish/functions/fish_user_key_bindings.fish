function fish_user_key_bindings
    bind \cz "fg&>/dev/null; echo; commandline -f repaint"
    bind \e\[3\;3~ kill-word
    bind \el "echo; exa --icons; commandline -f repaint"
    bind \cl "clear -x; printf '\e[6 q'; commandline -f repaint"
end
