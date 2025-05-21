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
  homeCfg = config.horseman;
in {
  options = {
    horseman.apps.visual = {
      enable = mkEnableOption "Apps that run in a visual window";
    };
  };

  config = mkIf cfg.enable {
    horseman.apps.visual = {
      firefox.enable = true;
    };

    environment.systemPackages = with pkgs; [
      bitwarden
      discord-ptb
      gnome-calculator
      inkscape
      kitty
      krita
      libreoffice
      mullvad-vpn
      zathura
      parsec-bin
      qbittorrent
      reaper
      solaar
      spotify
      vesktop
      vlc
    ];
  };
}
