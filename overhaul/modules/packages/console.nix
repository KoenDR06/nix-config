{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.terminal.pkgs;
in {
  options = {
    horseman.terminal.pkgs = {
      enable = mkEnableOption "Packages that are used in the terminal";
    };
  };

  config = mkIf cfg.enable {
    environment.packages = with pkgs; [
      direnv
      docker-compose
      efibootmgr
      ethtool
      file
      fzf
      gcc
      gnupg
      haskell.compiler.native-bignum.ghcHEAD
      haskell-language-server
      htop
      jdk
      neofetch
      nodejs_22
      python313
      platformio-core
      sops
      sqlite
      sxiv
      termdown
      tmux
      unzip
      wakeonlan
      zsh
      xclip
    ];
  };
}
