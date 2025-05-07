{ config, pkgs, ... }:

{
  services.unclutter = {
    enable = true;
    timeout = 5;
  };

  systemd.user = {
    services = {
      memos = {
        Unit.Description = "memos server";

        Service = with config; {
          ExecStart = "${pkgs.memos}/bin/memos -d ${xdg.dataHome}/memos/ -m prod";
          Restart = "always";
          RestartSec = 3;
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      mouseless = {
        Unit.Description = "mouseless";

        Service = with config; {
          ExecStartPre = "/bin/sleep 1";
          ExecStart = "${pkgs.mouseless}/bin/mouseless --config ${xdg.configHome}/mouseless/config.yaml";
        };

        Install.WantedBy = [ "multi-user.target" ];
      };
    };

    targets = { };

    paths = { };
  };

  xdg.configFile = {
    "systemd/user/mouseless.service" = {
      onChange = ''
        PATH=$PATH''\${PATH:+:}/usr/bin
        echo "%wheel ALL = NOPASSWD:${pkgs.mouseless}/bin/mouseless" | sudo tee /etc/sudoers.d/10-mouseless
        sudo chmod 644 /etc/sudoers.d/10-mouseless
      '';
    };
  };
}
