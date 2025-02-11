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

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  services.jack = {
    jackd.enable = false;
    alsa.enable = true;
    loopback.enable = false;
  };

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


  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "horseman" ];

  users.extraUsers.horseman.extraGroups = [ "jackaudio" ];
}
