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
      roboto-mono
      twitter-color-emoji
    ])
    ++ (with pkgs.nerd-fonts; [ fira-code ]);

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
      "FiraCode Nerd Font"
      "${jp-font}"
    ];
    defaultFonts.emoji = emoji-fonts;
  };
}
