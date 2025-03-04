{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.timers.backup;
  homeCfg = config.horseman;
in {
  options = {
    horseman.timers.backup = {
      enable = mkEnableOption "Enables the backup service";
    };
  };

  config = mkIf cfg.enable {
    assert homeCfg.network.syncthing || throw "Syncthing has not been enabled on this machine, refusing to add timer.";

    systemd.timers."backupsyncthing" = {
      wantedby = ["timers.target"];
      timerconfig = {
        oncalendar = "weekly";
        persistent = true;
      };
    };

    systemd.services."backupsyncthing" = {
      script = ''
        /home/horseman/nix-config/misc/backup.sh
      '';
      serviceconfig = {
        type = "oneshot";
        user = "horseman";
      };
    };
  };
}
