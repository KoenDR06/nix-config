{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.boot.refind;
in {
  options = {
    horseman.boot.refind = {
      enable = mkEnableOption "Enables rEFInd, the boot manager";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      refind
      efibootmgr
    ];
  };
}
