final: prev:
let
  nixpkgs =
    { rev, hash }:
    import (final.fetchFromGitHub {
      inherit rev hash;
      owner = "NixOS";
      repo = "nixpkgs";
    }) { inherit (final.stdenv.hostPlatform) system; };
in
{
  nullpkg = prev.stdenvNoCC.mkDerivation {
    name = "nullpkg";
    dontUnpack = true;
    buildPhase = "mkdir $out";
  };

  fcitx5-bamboo = prev.fcitx5-bamboo.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ../patches/fcitx5-bamboo-label.patch
    ];
  });

  polybar = prev.polybar.override {
    githubSupport = true;
    pulseSupport = true;
  };

  rofi = prev.rofi.override {
    plugins = [ final.rofi-emoji ];
  };

  tetrio-desktop = prev.tetrio-desktop.override { withTetrioPlus = true; };

  vesktop-icon = prev.stdenv.mkDerivation {
    name = "vesktop-icon";
    src = prev.fetchFromGitHub {
      owner = "Vencord";
      repo = "Vesktop";
      rev = "c0ba813041117ebd45a616f584148ae1fbbcdd55";
      hash = "sha256-oJyDHnU6c+oUMyUNJDTfsRM2WdnaOoaUN95yLadUlSA=";
    };

    installPhase = ''
      mkdir -p $out/icons/
      install -Dm0644 static/icon.png $out/icons/vesktop.png
    '';
  };
}
