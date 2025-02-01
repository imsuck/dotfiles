{ pkgs, ... }:

let
  username = "imsuck";
  homeDir = "/home/${username}";
in
{
  imports = [
    ./mod/helix.nix
    ./mod/yazi/yazi.nix
    ./mod/shell-things.nix
    ./mod/systemd.nix
  ];

  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = with pkgs; [
    bottom
    btop
    htop

    nix-tree
    nix-web

    memos
    neovim
    typst
    zellij
  ];

  home.file = { };

  xdg.configFile = { };

  home.sessionVariables = { };

  home.activation = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Do not touch
  home.stateVersion = "24.11";
}
