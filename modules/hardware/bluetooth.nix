{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.hardware.bluetooth;
in {
  options = {
    horseman.hardware.bluetooth = {
      enable = mkEnableOption "Bluetooth";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
  };
}
