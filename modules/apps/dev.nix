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

  config = mkIf cfg.enable {
    home-manager.users.${homeCfg.username} = {
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
        python313
        sqlite
        sqlitebrowser
        tmux
        xclip
      ];
    };
  };
}
