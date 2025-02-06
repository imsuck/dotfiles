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
    # nix things
    nix-tree
    nix-web

    # cli
    bacon
    bottom
    btop
    eza
    fd
    htop
    imagemagick
    megacmd
    neovim
    ripgrep
    zellij

    # other
    memos
    typst
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
