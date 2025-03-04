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
    systemd.timers."backupSyncthing" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
      };
    };

    systemd.services."backupSyncthing" = {
      script = ''
        /home/horseman/nix-config/misc/backup.sh
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "horseman";
      };
    };
  };
}
