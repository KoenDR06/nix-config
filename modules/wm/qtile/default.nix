{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.wm.qtile;
in {
  options = {
    horseman.wm.qtile = {
      enable = mkEnableOption "Qtile";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      windowManager.qtile.enable = true;
    };

    system.activationScripts.script.text = ''
      cd /home/horseman && \
      rm -r .config/qtile && \
      cp -r nix-config/modules/wm/qtile/config \
            .config/qtile && \
      sudo chown -R horseman:users .config/qtile
    '';
  };
}
