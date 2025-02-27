{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.greeter.sddm;
in {
  options = {
    horseman.boot.greeter.sddm = {
      enable = mkEnableOption "SDDM Greeter";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
  };
}
