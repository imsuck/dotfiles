{ pkgs, ... }:

{
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-bamboo
    fcitx5-mozc-ut
    fcitx5-tokyonight
  ];
}
