function yazi
    if set -q ZELLIJ
        TERM=xterm-kitty command yazi $argv[1..-1]
    else
        command yazi $argv[1..-1]
    end
end
