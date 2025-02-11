{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.packages.visual;
in {
  options = {
    horseman.packages.visual = {
      enable = mkEnableOption "Programs that open in a window on the screen";
    };
  };

  config = mkIf cfg.enable {
    environment.packages = with pkgs; [
      alacritty
      bitwarden
      discord-ptb
      ghex
      gnome-calculator # Should be replaced, opens up so slowww
      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.rider
      jetbrains.webstorm
      inkscape
      keepassxc
      krita
      libreoffice
      mullvad-vpn
      parsec-bin
      qbittorrent
      reaper
      retext
      solaar
      spotify
      sqlitebrowser
      thunderbird
      vlc
    ];
  };
}
