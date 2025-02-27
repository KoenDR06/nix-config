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

  networking.hostName = "solis";

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

  system.stateVersion = "24.11";
}
