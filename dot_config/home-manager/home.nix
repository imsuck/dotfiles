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
    ./mod/services.nix
    ./mod/shell-things.nix
    ./mod/thumbnailers.nix
  ];

  home.username = "imsuck";
  home.homeDirectory = "/home/${config.home.username}";

  home.packages =
    with pkgs;
    [
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
      nitrogen
      polybar
      libqalculate
      qalculate-gtk
      rofi

      # other
      autotiling
      julia-bin
      ksuperkey
      memos
      porsmo
      sccache
      typst
      unclutter-xfixes
    ]
    ++ (
      with pkgs;
      map config.lib.nixGL.wrap [
        # desktop
        alacritty
        picom
        tetrio-desktop
        vesktop
      ]
    );

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
