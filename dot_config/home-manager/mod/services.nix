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
    };

    targets = { };

    paths = { };
  };
}
