{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.wm.cosmic;
in {
  options = {
    horseman.wm.cosmic = {
      enable = mkEnableOption "COSMIC";
    };
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic = {
      enable = true;
    };
  };
}
