function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert ctrl-n down-or-search

    bind \cz "fg&>/dev/null; echo; commandline -f repaint"
    bind -M insert \e\[3\;3~ kill-word
    bind \el "echo; eza -F --icons=auto; commandline -f repaint"
    bind -M insert \el "echo; eza -F --icons=auto; commandline -f repaint"
end
