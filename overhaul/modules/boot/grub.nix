{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.grub;
in {
  options = {
    horseman.boot.grub = {
      enable = mkEnableOption "Enables grub, the bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
      configurationLimit = 10;
    };
  };
}
