{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.apps.terminal;
in {
  options = {
    horseman.apps.terminal = {
      enable = mkEnableOption "Apps that run only in terminal without a GUI";
    };
  };

  config = {
    services.lorri.enable = true;

    environment.systemPackages = with pkgs; [
    ];
  };
}
