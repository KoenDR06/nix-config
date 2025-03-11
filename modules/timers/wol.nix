{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.timers.wol;
  homeCfg = config.horseman;
in {
  options = {
    horseman.timers.wol = {
      enable = mkEnableOption "Enables Wake on LAN on boot";
    };
  };

  config = mkIf cfg.enable {
    systemd.timers."enable-wol" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "10s";
        Unit = "enable-wol.service";
      };
    };

    systemd.services."enable-wol" = {
      script = ''
        /home/horseman/nix-config/misc/startup.sh
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
  };
}
