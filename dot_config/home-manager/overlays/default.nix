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
  fcitx5-bamboo = prev.fcitx5-bamboo.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ../patches/fcitx5-bamboo-label.patch
    ];
  });

  # Should still work. I just don't want to evaluate another nixpkgs.
  pavucontrol = prev.stdenv.mkDerivation rec {
    pname = "pavucontrol";
    version = "5.0";

    src = prev.fetchurl {
      url = "https://freedesktop.org/software/pulseaudio/${pname}/${pname}-${version}.tar.xz";
      sha256 = "sha256-zityw7XxpwrQ3xndgXUPlFW9IIcNHTo20gU2ry6PTno=";
    };

    buildInputs = with prev; [
      libpulseaudio
      gtkmm3
      libsigcxx
      libcanberra-gtk3
      json-glib
      adwaita-icon-theme
    ];

    nativeBuildInputs = with prev; [
      pkg-config
      intltool
      wrapGAppsHook3
    ];

    configureFlags = [ "--disable-lynx" ];

    enableParallelBuilding = true;
  };

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
