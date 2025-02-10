{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.common.locale;
in {
  options = {
    horseman.common.locale = {
      enable = mkEnableOption "Dutch locale settings";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Amsterdam";
  };
}
