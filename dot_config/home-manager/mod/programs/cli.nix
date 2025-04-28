{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      batwatch
    ];
  };
  programs.mise = {
    enable = true;
  };
  programs.nix-index.enable = true;
}
