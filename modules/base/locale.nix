{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.base.locale;
in {
  options = {
    horseman.base.locale = {
      enable = mkEnableOption "Locale settings";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Amsterdam";
  };
}
