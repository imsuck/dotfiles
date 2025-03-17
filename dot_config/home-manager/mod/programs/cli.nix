{ pkgs, ... }:

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
  programs.fzf = {
    enable = true;
    defaultCommand = "fd -Ltf";
    fileWidgetCommand = "fd -Ltf";
    defaultOptions = [ "--min-height=10 --height=20%" ];
    fileWidgetOptions = [ "--min-height=10 --height=20%" ];
    historyWidgetOptions = [ "--min-height=10 --height=20%" ];
  };
  programs.nix-index.enable = true;
  programs.zoxide.enable = true;
}
