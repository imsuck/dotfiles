{ config, pkgs, ... }:

{
  imports = [
    ./mod/fcitx5.nix
    ./mod/fonts.nix
    ./mod/git.nix
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
    bat
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
    julia-bin
    memos
    typst
  ];

  home.file = { };

  xdg.configFile = { };

  home.sessionVariables = {
    BROWSER = "firefox";
    PAGER = "bat";
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
  ];

  home.activation = { };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
