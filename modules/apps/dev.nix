{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.apps.dev;
in {
  options = {
    horseman.apps.dev = {
      enable = mkEnableOption "Apps used for programming";
    };
  };

  config = {
    # Docker
    virtualisation.docker.enable = true;
  };
}
