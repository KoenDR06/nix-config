{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.hardware.wifi;
in {
  options = {
    horseman.hardware.wifi = {
      enable = mkEnableOption "";
    };
  };

  config = {
    networking.networkmanager.enable = true;
    users.users.horseman.extraGroups = ["networkmanager"];
  };
}
