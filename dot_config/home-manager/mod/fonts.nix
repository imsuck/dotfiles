{ pkgs, ... }:

let
  jp-font = "Fusion Kai J"; # "Fusion Kai J", "Noto Sans CJK JP"
  emoji-fonts = [
    "Twitter Color Emoji"
    "Noto Color Emoji"
  ];
in
{
  home.packages = with pkgs; [
    fira-code
    icomoon-feather
    lxgw-fusionkai
    roboto-mono
    twitter-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.sansSerif = [
      "Noto Sans"
      "${jp-font}"
    ] ++ emoji-fonts;
    defaultFonts.serif = [
      "Noto Serif"
      "${jp-font}"
    ];
    defaultFonts.monospace = [
      "Fira Code"
      "${jp-font}"
    ];
    defaultFonts.emoji = emoji-fonts;
  };
}
