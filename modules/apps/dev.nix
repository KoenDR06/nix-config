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
  homeCfg = config.horseman;
in {
  options = {
    horseman.apps.dev = {
      enable = mkEnableOption "Apps used for programming";
    };
  };

  config = {
    home-manager.users.${homeCfg.username} = {
      programs = {
        gh.enable = true;
        git = {
          enable = true;
          userName = "KoenDR06";
          userEmail = "koen.de.ruiter@hotmail.com";
        };
      };

      home.packages = with pkgs; [
        gcc
        ghex
        haskell.compiler.native-bignum.ghcHEAD
        haskell-language-server
        jdk
        jetbrains.clion
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.rider
        jetbrains.webstorm
        nodejs_22
        platformio-core
        python314
        sqlite
        sqlitebrowser
        tmux
        xclip
      ];
    };

    # Docker
    virtualisation.docker.enable = true;
  };
}
