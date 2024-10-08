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

  services.samba = {
    enable = false;
    securityType = "user";
    openFirewall = true;
    shares = {
      public = {
        path = "/home/horseman/mnt/sda1";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "user";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
