{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      tabs 4

      batman --export-env | source
      # set -gx FZF_DEFAULT_COMMAND "fd --type file --follow"
      # set -gx FZF_CTRL_T_COMMAND "fd --type file --follow"
      # set -gx FZF_DEFAULT_OPTS "--height 20%"

      # if ! set -q ZELLIJ
      #   exec zellij
      # end
    '';
    shellInitLast = ''
      if not functions -q _fish_prompt
        functions --copy fish_prompt _fish_prompt
        function fish_prompt
          printf "\e[0 q" # reset cursor
          _fish_prompt
        end
      end
    '';
    functions = {
      d = ''
        while test $PWD != /
          if test -d .git
            break
          end
          cd ..
        end
      '';
      fish_user_key_bindings = ''
        bind \cz "fg&>/dev/null; echo; fish_prompt"
        bind \e\[3\;5~ kill-word
        bind \e\[3\;3~ kill-word
        bind \el "echo; exa --icons; fish_prompt"
        bind \cl "clear -x; printf '\e[6 q'; fish_prompt"
      '';
      fish_command_not_found = "__fish_default_command_not_found_handler $argv";
      fish_greeting = "";
    };
    shellAbbrs = {
      "..." = "../../";
      "...." = "../../../";
      "....." = "../../../../";
      c = "cargo";
      ct = "cargo test";
      df = "duf -theme ansi";
      e = "hx";
      g = "git";
      gc = "git checkout";
      ga = "git add -p";
      pr = "gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)";
      l = "exa --icons";
      ls = "exa --icons";
      ll = "exa -l --icons";
      lll = "exa -la --icons";
      m = "make";
      o = "handlr open";
      p = "sudo pacman";
      wtr = "curl 'wttr.in/?qF'";
      yr = "cal -y";
      yz = "yazi";
      ze = "zellij";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "bass";
        src = bass.src;
      }
    ];
  };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 2000;
      format = "$time $all";
      right_format = "$cmd_duration";

      character = {
        success_symbol = "";
        error_symbol = "";
        disabled = true;
      };

      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
        format = "[$duration]($style) ";
        disabled = false;
      };

      directory = {
        # truncation_symbol = "…/";
        format = "[ ](bg:blue)[ $path ](bg:black) ";
        use_os_path_sep = false;
      };

      git_branch = {
        format = "[ ](bg:purple)[ $symbol$branch ](bg:black)";
        symbol = "";
      };

      git_status = {
        format = "([$all_status$ahead_behind ]($style)) ";
        style = "fg:cyan bold bg:black";
        deleted = "-";
      };

      git_commit.format = "[ ](bg:purple)[ $hash$tag ](bg:black)";

      nix_shell = {
        impure_msg = "[ ](bg:red)";
        pure_msg = "[ ](bg:green)";
        unknown_msg = "[ ](bg:yellow)";
        format = "$state[ $name ](bg:black) ";
      };

      rust = {
        symbol = "rs";
        version_format = "";
        format = "[ ](bg:red)[ $symbol$version ](bg:black) ";
      };

      nodejs = {
        symbol = "node";
        version_format = "";
        format = "[ ](bg:green)[ $symbol$version ](bg:black) ";
      };

      c = {
        symbol = "C";
        version_format = "";
        format = "[ ](bg:green)[ $symbol$version ](bg:black) ";
      };

      python.disabled = true;

      status = {
        format = "[\\[$status\\]](bold red) ";
        disabled = false;
      };

      time = {
        format = "[ ](bg:yellow)[ $time ](bg:black)";
        time_format = "%R";
        style = "yellow bold";
        disabled = false;
      };

      line_break.disabled = true;

      package.disabled = true;
    };
  };
}
