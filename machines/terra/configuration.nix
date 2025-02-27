{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
    ../../modules
  ];

  horseman.username = "horseman";

  networking.hostName = "terra";

  systemd.timers."enable-wol" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1m";
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

  system.stateVersion = "24.11";
}
