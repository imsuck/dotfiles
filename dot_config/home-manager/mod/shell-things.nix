{ ... }:

{
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
