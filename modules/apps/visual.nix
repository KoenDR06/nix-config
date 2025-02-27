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

  config = {
    horseman.apps.visual = {
      firefox.enable = true;
    };

    environment.systemPackages = with pkgs; [
      alacritty
      albert
      bitwarden
      discord-ptb
      gnome-calculator
      inkscape
      keepassxc
      krita
      libreoffice
      mullvad-vpn
      parsec-bin
      qbittorrent
      reaper
      solaar
      spotify
      vlc
    ];
  };
}
