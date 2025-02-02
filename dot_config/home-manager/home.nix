{ config, pkgs, ... }:

{
  imports = [
    ./mod/helix.nix
    ./mod/yazi/yazi.nix
    ./mod/shell-things.nix
    ./mod/systemd.nix
    ./mod/thumbnailers.nix
  ];

  home.username = "imsuck";
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs; [
    bottom
    btop
    htop
    imagemagick
    nix-tree
    nix-web
    megacmd
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
