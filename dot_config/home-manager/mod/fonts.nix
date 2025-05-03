{ pkgs, ... }:

let
  jp-font = "Fusion Kai J"; # "Fusion Kai J", "Noto Sans CJK JP"
  emoji-fonts = [
    "Twitter Color Emoji"
    "Noto Color Emoji"
  ];
in
{
  home.packages =
    (with pkgs; [
      fira-code
      font-awesome
      icomoon-feather
      lxgw-fusionkai
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      roboto-mono
      twitter-color-emoji
    ])
    ++ (with pkgs.nerd-fonts; [ fira-code ]);

  fonts.fontconfig = {
    enable = true;
    defaultFonts.sansSerif = [
      "Noto Sans"
      "${jp-font}"
      "Noto Sans CJK KR"
    ] ++ emoji-fonts;
    defaultFonts.serif = [
      "Noto Serif"
      "${jp-font}"
      "Noto Serif CJK KR"
    ] ++ emoji-fonts;
    defaultFonts.monospace = [
      "FiraCode Nerd Font"
      "Noto Sans Mono"
      "${jp-font}"
    ] ++ emoji-fonts;
    defaultFonts.emoji = emoji-fonts;
  };
}
