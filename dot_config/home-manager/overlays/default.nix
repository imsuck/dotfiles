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
  rofi-ime-support = nixpkgs {
    rev = "5e38027890fa368b7de5fb3b4b0788674156168f";
    hash = "sha256-DyWYUR56YvONf7Bzq5Dj6yl4bwL0+J/iDZ5cMkRe2Y4=";
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

  rofi = rofi-ime-support.rofi.override {
    plugins = [ final.rofi-emoji ];
  };

  tetrio-desktop = prev.tetrio-desktop.override { withTetrioPlus = true; };
}
