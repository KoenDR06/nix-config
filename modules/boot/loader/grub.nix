{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.loader.grub;
in {
  options = {
    horseman.boot.loader.grub = {
      enable = mkEnableOption "Sets grub as the bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.configurationLimit = 10;
  };
}
