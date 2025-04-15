{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.apps.server;
in {
  options = {
    horseman.apps.server = {
      enable = mkEnableOption "Apps that only need to be installed on servers";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      certbot
    ];
  };
}
