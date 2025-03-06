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
      xdg-desktop-portal-hyprland
      nerdfonts
      networkmanagerapplet
    ];
  };
}
