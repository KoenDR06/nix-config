{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman;
in {
  options = {
    horseman = {
      username = mkOption { type = types.str; };
    };
  };
}
