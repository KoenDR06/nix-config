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

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true;
  services.xserver.displayManager.defaultSession = "plasma";
  boot.loader.systemd-boot.enable = true;  
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  programs.ssh.askPassword = lib.mkForce "/nix/store/qrzq7dqp8dkffb5dvi42q647dhm87ady-ksshaskpass-6.0.3/bin/ksshaskpass";

  hardware.pulseaudio.enable = true;
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback.enable = true;
  };

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
