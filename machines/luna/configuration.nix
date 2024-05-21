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
    ../../pkgs/firefox.nix
    ../common/configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      horseman = import ../../home-manager/apps.nix;
    };
  };

  networking.hostName = "luna";

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true;
  services.xserver.displayManager.defaultSession = "plasmax11";
  boot.loader.systemd-boot.enable = true;  
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  hardware.pulseaudio.enable = true;
  networking.networkmanager.enable = true;

  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback.enable = true;
  };

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
