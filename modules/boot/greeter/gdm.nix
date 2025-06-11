{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.greeter.gdm;
in {
  options = {
    horseman.boot.greeter.gdm = {
      enable = mkEnableOption "GDM Greeter";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
    };
  };
}
