{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.wm.hyprland;
in {
  options = {
    horseman.wm.hyprland = {
      enable = mkEnableOption "HyprLand";
    };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    security.polkit.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
      eww
      fortune
      hyprlock
      hyprshot
      jq
      networkmanagerapplet
      playerctl
      pulsemixer
      python312Packages.gpustat
      swaybg
      wofi
      xdg-desktop-portal-hyprland
    ];

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';

    system.activationScripts.script.text = ''
      cd /home/horseman;
      rm -r .config/hypr .config/eww .config/wofi;
      cp -r nix-config/modules/wm/hyprland/config/* .config;
      chown -R horseman:users .config/hypr .config/eww .config/wofi
    '';
  };
}
