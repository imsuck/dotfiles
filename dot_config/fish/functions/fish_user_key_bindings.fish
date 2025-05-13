function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert

    bind \cz "fg&>/dev/null; echo; commandline -f repaint"
    bind -M insert \e\[3\;3~ kill-word
    bind \el "echo; eza --icons always; commandline -f repaint"
    bind -M insert \el "echo; eza --icons always; commandline -f repaint"
end
