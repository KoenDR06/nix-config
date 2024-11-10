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
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    127.0.0.1 koala.rails.local members.rails.local leden.rails.local intro.rails.local
  '';

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.defaultSession = "plasma";
  boot.loader.systemd-boot.enable = true;  
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  services.jack = {
    jackd.enable = false;
    alsa.enable = true;
    loopback.enable = false;
  };

  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "horseman" ];

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
