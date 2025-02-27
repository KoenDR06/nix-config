{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.wm.gnome;
in {
  options = {
    horseman.wm.gnome = {
      enable = mkEnableOption "Gnome";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };

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

    home-manager.users.horseman = {
      imports = [./config.nix];
    };
  };
}
