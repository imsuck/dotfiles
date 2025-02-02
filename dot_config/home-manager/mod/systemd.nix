{ config, pkgs, ... }:

with config;
{
  systemd.user.services = {
    memos = {
      Unit.Description = "memos server";

      Service = {
        ExecStart = "${pkgs.memos}/bin/memos -d ${xdg.dataHome}/memos/ -m prod";
        Restart = "always";
        RestartSec = 3;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
