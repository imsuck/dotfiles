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
}
