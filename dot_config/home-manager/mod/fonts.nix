{ pkgs, ... }:

let
  jp-font = "Fusion Kai J"; # "Fusion Kai J", "Noto Sans CJK JP"
in {
  home.packages = with pkgs; [
    lxgw-fusionkai
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [
      "Fira Code"
      "${jp-font}"
    ];
    defaultFonts.sansSerif = [
      "Noto Sans"
      "${jp-font}"
    ];
    defaultFonts.serif = [
      "Noto Serif"
      "${jp-font}"
    ];
    defaultFonts.emoji = [
      "Twemoji"
      "Noto Color Emoji"
    ];
  };
}
