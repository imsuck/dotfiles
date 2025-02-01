{ pkgs, ... }:

let
  username = "imsuck";
  homeDir = "/home/${username}";
in
{
  systemd.user.services = {
    memos = {
      Unit.Description = "memos server";

      Service = {
        ExecStart = "${pkgs.memos}/bin/memos -d ${homeDir}/.local/share/memos/ -m prod";
        Restart = "always";
        RestartSec = 3;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
