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
    ./refind.nix
    ../../pkgs/firefox.nix
    ../common/configuration.nix
  ];

  # NVIDIA Drivers
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # End NVIDIA


  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      horseman = import ../../home-manager/apps.nix;
    };
  };

  networking.hostName = "terra";

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true;
  services.xserver.displayManager.sddm.wayland.enable = false;
  services.xserver.displayManager.defaultSession = "plasma";
  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  hardware.pulseaudio.enable = true;

   services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
