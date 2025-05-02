if not functions -q _fish_prompt
    functions --copy fish_prompt _fish_prompt
    function fish_prompt
        _fish_prompt
        printf "\e[0 q" # reset cursor
    end
end
