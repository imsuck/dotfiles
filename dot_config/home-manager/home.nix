{ config, lib, pkgs, ... }:

{
  imports = [
    ./mod/helix.nix
    ./mod/shell-things.nix
  ];

  home.username = "imsuck";
  home.homeDirectory = "/home/imsuck";

  home.packages = with pkgs; [
    bottom btop htop
    neovim
    nix-tree nix-web
    typst
    zellij
  ];

  home.file = {};

  xdg.configFile = {};

  home.sessionVariables = {
    # EDITOR = "hx";
  };

  home.activation = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Do not touch
  home.stateVersion = "24.11";
}
