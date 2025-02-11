{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.xxxxxx.xxxxxx;
in {
  options = {
    horseman.xxxxxx.xxxxxx = {
      enable = mkEnableOption "";
    };
  };

  config = mkIf cfg.enable {
    
  };
}
