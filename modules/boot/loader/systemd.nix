{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.loader.systemd;
in {
  options = {
    horseman.boot.loader.systemd = {
      enable = mkEnableOption "Sets systemd as the bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 10;
  };
}
