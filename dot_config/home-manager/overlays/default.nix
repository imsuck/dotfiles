final: prev:
let
  nixpkgs =
    { rev, hash }:
    import (final.fetchFromGitHub {
      inherit rev hash;
      owner = "NixOS";
      repo = "nixpkgs";
    }) { inherit (final.stdenv.hostPlatform) system; };
  pavucontrol-gtk3 = nixpkgs {
    rev = "b60793b86201040d9dee019a05089a9150d08b5b";
    hash = "sha256-PlL/yXNX/C87S2N8lF/HfOJhHForf/l7E6lVWZ4jMrw=";
  };
in
{
  fcitx5-bamboo = prev.fcitx5-bamboo.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ../patches/fcitx5-bamboo-label.patch
    ];
  });

  pavucontrol = pavucontrol-gtk3.pavucontrol;

  polybar = prev.polybar.override {
    githubSupport = true;
    pulseSupport = true;
  };

  rofi = prev.rofi.override {
    plugins = [ final.rofi-emoji ];
  };

  tetrio-desktop = prev.tetrio-desktop.override { withTetrioPlus = true; };
}
