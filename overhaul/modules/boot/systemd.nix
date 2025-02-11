{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.systemd;
in {
  options = {
    horseman.boot.systemd = {
      enable = mkEnableOption "Enables systemd, the bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
}
