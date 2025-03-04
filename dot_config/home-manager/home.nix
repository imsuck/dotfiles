{
  config,
  pkgs,
  nixgl,
  ...
}:

{
  imports = [
    ./mod/cli.nix
    ./mod/fcitx5.nix
    ./mod/files.nix
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
    dust
    eza
    fd
    handlr
    imagemagick
    megacmd
    neovim
    ripdrag
    ripgrep
    watchexec
    zellij

    # desktop
    (config.lib.nixGL.wrap alacritty)
    nitrogen
    (config.lib.nixGL.wrap picom)
    (polybar.override {
      githubSupport = true;
      pulseSupport = true;
    })
    libqalculate
    qalculate-gtk
    (rofi.override { plugins = [ rofi-emoji ]; }) # too lazy to port config

    # other
    autotiling
    julia-bin
    ksuperkey
    memos
    sccache
    typst
    unclutter-xfixes
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = "auto";
    };
    gc = {
      automatic = true;
      frequency = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  nixGL.packages = nixgl.packages;
  nixGL.installScripts = [ "mesa" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import ./overlays)
    ];
  };

  home.pointerCursor = {
    package = pkgs.posy-cursors;
    name = "Posy_Cursor";
  };

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
