{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  headless,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.wm.plasma;
  homeCfg = config.horseman;
in {
  options = {
    horseman.wm.plasma = {
      enable = mkEnableOption "Plasma 6";
    };
  };

  config = {
    services = {
      xserver.enable = true;

      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm.autoNumlock = true;
      };

      power-profiles-daemon.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
    ];

    home-manager.users.${homeCfg.username} = lib.mkIf (!headless) {
      imports = [./config.nix];
    };
  };
}
