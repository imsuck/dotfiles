{
  config,
  pkgs,
  nixgl,
  ...
}:

{
  imports = [
    ./mod/programs
    ./mod/desktop.nix
    ./mod/files.nix
    ./mod/fonts.nix
    ./mod/services.nix
    ./mod/shell-apps.nix
    ./mod/thumbnailers.nix
  ];

  home.username = "imsuck";
  home.homeDirectory = "/home/${config.home.username}";

  home.packages =
    with pkgs;
    [
      # nix things
      comma
      nix-output-monitor
      nix-tree
      nvd

      # cli
      cht-sh
      megacmd
      nb

      # desktop
      mouseless

      # other
      memos
      porsmo
    ]
    ++ (
      with pkgs;
      map config.lib.nixGL.wrap [
        # desktop
      ]
    );

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "ca-derivations"
        "nix-command"
        "flakes"
      ];
      max-jobs = "auto";
    };
    gc = {
      automatic = false;
      frequency = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  # nixGL.packages = nixgl.packages;
  # nixGL.installScripts = [ "mesa" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # contentAddressedByDefault = true;
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
    HM_FLAKE = "$HOME/.config/home-manager";
    COMMA_NIXPKGS_FLAKE = "$HOME/.config/home-manager";
    PAGER = "bat";
    RUSTC_WRAPPER = "sccache";
    VISUAL = "$HOME/.nix-profile/bin/hx";

    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
  ];

  home.activation = { };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
