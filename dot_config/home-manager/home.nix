{ config, lib, pkgs, ... }:

{
  imports = [
    ./mod/helix.nix
    ./mod/shell-things.nix
  ];

  home.username = "imsuck";
  home.homeDirectory = "/home/imsuck";

  home.packages = with pkgs; [
    bottom btop htop
    neovim
    nix-tree nix-web
    opentabletdriver
    typst
    zellij
  ];

  home.file = {};

  xdg.configFile = {
    "systemd/user/opentabletdriver.service".text = ''
      [Unit]
      Description=OpenTabletDriver Daemon
      PartOf=graphical-session.target
      After=graphical-session.target
      ConditionEnvironment=|WAYLAND_DISPLAY
      ConditionEnvironment=|DISPLAY

      [Service]
      ExecStart=${pkgs.opentabletdriver}/bin/otd-daemon
      Restart=always
      RestartSec=3

      [Install]
      WantedBy=graphical-session.target
    '';
  };

  home.sessionVariables = {
    # EDITOR = "hx";
  };

  home.activation = {
    enableOTDDaemon = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # very bad!!!
      _ctl="/usr/bin/systemctl"
      if command -v $_ctl 2>&1 >/dev/null; then
        $_ctl enable --user --now opentabletdriver
        $_ctl --user daemon-reload
      else
        printf "\e[31mFailed to reload opentabletdriver daemon\e[0m\n"
      fi
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Do not touch
  home.stateVersion = "24.11";
}
