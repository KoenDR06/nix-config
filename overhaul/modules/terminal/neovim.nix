{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.terminal.neovim;
in {
  options = {
    horseman.terminal.neovim = {
      enable = mkEnableOption "Neovim options";
    };
  };

  config = mkIf cfg.enable {
    
  };
}
