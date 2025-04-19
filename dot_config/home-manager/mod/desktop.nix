{ pkgs, ... }:
{
  xdg.desktopEntries = {
    vesktop = {
      name = "Vesktop";
      exec = "vesktop %U";
      icon = "${pkgs.vesktop-icon}/icons/vesktop.png";
      genericName = "Internet Messenger";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
    };
  };
}
