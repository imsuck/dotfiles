function fish_user_key_bindings
    bind \cz "fg&>/dev/null; echo; fish_prompt"
    bind \e\[3\;3~ kill-word
    bind \el "echo; exa --icons; fish_prompt"
    bind \cl "clear -x; printf '\e[6 q'; fish_prompt"
end
