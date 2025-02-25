{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.xxx.yyy;
in {
  options = {
    horseman.xxx.yyy = {
      enable = mkEnableOption "";
    };
  };

  config = {
  };
}
