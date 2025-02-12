{ config, pkgs, ... }:

{
  imports = [
    ./mod/cli.nix
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
    nvd

    # cli
    bacon
    bottom
    btop
    duf
    eza
    fd
    handlr
    htop
    imagemagick
    megacmd
    neovim
    ripgrep
    zellij

    # desktop
    polybarFull
    (rofi.override { plugins = [ rofi-emoji ]; }) # too lazy to port config

    # other
    julia-bin
    memos
    typst
    sccache
  ];

  home.file = { };

  xdg.configFile = { };

  home.sessionVariables = {
    BROWSER = "firefox";
    CARGO_HOME = "$HOME/.local/share/cargo";
    PAGER = "bat";
    RUSTC_WRAPPER = "sccache";
    VISUAL = "$HOME/.nix-profile/bin/hx";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
  ];

  home.activation = { };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
