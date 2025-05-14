# IME
set -gx GLFW_IM_MODULE 'ibus'
set -gx GTK_IM_MODULE 'fcitx'
set -gx QT_IM_MODULE 'fcitx'
set -gx XMODIFIERS '@im=fcitx'

set -gx PATH "$HOME"'/.local/bin:'"$CARGO_HOME"'/bin'(test -n "$PATH" && echo ':' || echo)"$PATH"
set -gx BROWSER 'firefox'
set -gx EDITOR 'helix'
set -gx VISUAL 'helix'
set -gx PAGER 'bat'
set -gx LS_COLORS (vivid generate tokyonight-storm)

set -gx CARGO_HOME "$HOME"'/.local/share/cargo'
set -gx RUSTC_WRAPPER 'sccache'

set -gx FZF_DEFAULT_COMMAND "fd -LH --no-ignore-vcs --color=always"
set -gx FZF_DEFAULT_OPTS '--ansi --bind ctrl-d:half-page-down,ctrl-u:half-page-up --min-height 10 --height 50% --preview "~/scripts/fzf_preview.sh {}"'
set -gx FZF_CTRL_T_COMMAND "fd -LH --no-ignore-vcs --color=always --search-path \$dir | sed s#\\\\./##"
set -gx FZF_ALT_C_COMMAND "fd -LHtd --no-ignore-vcs --color=always --search-path \$dir |  sed s#\\\\./##"
set -gx FZF_CTRL_R_OPTS '--preview ""'

set -gx HM_FLAKE "$HOME"'/.config/home-manager'
set -gx COMMA_NIXPKGS_FLAKE "$HOME"'/.config/home-manager'
set -gx XCURSOR_SIZE '32'
set -gx XCURSOR_THEME 'Posy_Cursor'
set -gx XCURSOR_PATH '/home/imsuck/.nix-profile/share/icons'(test -n "$XCURSOR_PATH" && echo ':' || echo)"$XCURSOR_PATH"

status is-login; and begin

end

status is-interactive; and begin

    # Abbreviations
    abbr --add -- ... ../../
    abbr --add -- .... ../../../
    abbr --add -- ..... ../../../../
    abbr --add -- c cargo
    abbr --add -- ct 'cargo test'
    abbr --add -- df 'duf -theme ansi'
    abbr --add -- e helix
    abbr --add -- g git
    abbr --add -- ga 'git add -p'
    abbr --add -- gc 'git checkout'
    abbr --add -- l 'eza --icons'
    abbr --add -- ll 'eza -l --icons --no-time'
    abbr --add -- lll 'eza -la --icons --no-time'
    abbr --add -- ls 'eza --icons'
    abbr --add -- m make
    abbr --add -- o 'handlr open'
    abbr --add -- p 'sudo pacman'
    abbr --add -- pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'
    abbr --add -- tm tmux
    abbr --add -- wtr 'curl wttr.in/?qF'
    abbr --add -- yr 'cal -y'
    abbr --add -- yz yazi
    abbr --add -- ze zellij

    # Aliases

    # Interactive shell initialisation
    fzf --fish | source

    tabs 4

    batman --export-env | source

    # if ! set -q ZELLIJ
    #   exec zellij
    # end

    set fish_color_command blue
    set fish_greeting
    set __mise_command_not_found

    zoxide init fish | source

    if test "$TERM" != dumb
        starship init fish | source
    end

    mise activate fish | source

    set -g fish_key_bindings fish_vi_key_bindings

    zellij_tab_name_update
end

# if not functions -q _fish_prompt
#     functions --copy fish_prompt _fish_prompt
#     function fish_prompt
#         _fish_prompt
#         printf "\e[0 q" # reset cursor
#         commandline -f repaint
#     end
# end
