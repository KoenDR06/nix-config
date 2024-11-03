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
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;
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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
  ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-calendar
    gnome-characters
    nautilus
    gnome-clocks
    gnome-contacts
    evince
    file-roller
    geary
    gnome-system-monitor
    eog
    gnome-logs
    gnome-maps
    gnome-music
    seahorse
    gnome-text-editor
  ];

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.sddm.wayland.enable = false;
  services.displayManager.defaultSession = "plasma";
  boot.loader.systemd-boot.enable = true;

  programs.ssh.askPassword = lib.mkForce "/nix/store/qrzq7dqp8dkffb5dvi42q647dhm87ady-ksshaskpass-6.0.3/bin/ksshaskpass";

  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;

  hardware.pulseaudio.enable = false;
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback.enable = true;
  };

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
