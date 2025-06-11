{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.greeter.cosmic;
in {
  options = {
    horseman.boot.greeter.cosmic = {
      enable = mkEnableOption "COSMIC Greeter";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.cosmic-greeter = {
      enable = true;
    };
  };
}
