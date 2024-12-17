{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../common/configuration.nix
    ../../modules/sleep-at-night.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      horseman = import ../../home-manager/server-apps.nix;
    };
  };

  networking.hostName = "solis";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  virtualisation.docker.enable = true;

  services.resolved.enable = true;
  services.resolved.extraConfig = "DNSStubListener=no\n";

  systemd.timers."backupSyncthing" = {
    wantedBy = [ "timers.target" ];
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

  services.sleep-at-night = {
    enable = true;
    shutdown = {
      hour = 00;
      minute = 30;
    };
    wakeup = "08:00:00";
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
