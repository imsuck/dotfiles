final: prev:
let
  nixpkgs =
    { rev, hash }:
    import (final.fetchFromGitHub {
      inherit rev hash;
      owner = "NixOS";
      repo = "nixpkgs";
    }) { inherit (final.stdenv.hostPlatform) system; };
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

  polybar = prev.polybar.override {
    githubSupport = true;
    pulseSupport = true;
  };

  rofi = rofi-ime-support.rofi.override {
    plugins = [ final.rofi-emoji ];
  };

  tetrio-desktop = prev.tetrio-desktop.override { withTetrioPlus = true; };
}
