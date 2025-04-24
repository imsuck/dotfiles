{ lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      batwatch
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fd = {
    enable = true;
    ignores = [ ".git" ];
  };
  programs.fzf = {
    enable = true;
    defaultCommand = "fd -Ltf --no-hidden";
    fileWidgetCommand = ''fd -Ltf --search-path "\$dir" --no-hidden | sed "s#^\./##"'';
    defaultOptions = [
      "--min-height 10 --height 20%"
      "--preview '~/scripts/fzf_preview.sh {}'"
    ];
    fileWidgetOptions = [ ];
    historyWidgetOptions = [ ];
  };
  programs.nix-index.enable = true;
  programs.television = {
    enable = false;
    settings = {
      ui = {
        ui_scale = 90;
      };
      shell_integration.channel_triggers = {
        git-repos = [ ];
      };
    };
  };
  programs.zoxide.enable = true;
}
