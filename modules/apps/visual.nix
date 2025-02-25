{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.apps.visual;
in {
  options = {
    horseman.apps.visual = {
      enable = mkEnableOption "Apps that run in a visual window";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
    ];
  };
}
