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
    rev = "82be07453bb0cdf6b467559c92f901bd040557ae";
    hash = "sha256-eaSBFWZv0WsyRViEV7jWypLRhdfte9MhjvWWKiLBToY=";
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

  rofi =
    with rofi-ime-support;
    rofi.override {
      plugins = [ final.rofi-emoji ];
      rofi-unwrapped = rofi-unwrapped.override { imeSupport = true; };
    };

  tetrio-desktop = prev.tetrio-desktop.override { withTetrioPlus = true; };
}
