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
    environment.systemPackages = with pkgs; [
      dotnetCorePackages.sdk_9_0
      gcc
      ghex
      haskell.compiler.native-bignum.ghcHEAD
      haskell-language-server
      jdk
      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.rider
      jetbrains.rust-rover
      jetbrains.webstorm
      mono
      nixd
      nodejs_22
      platformio-core
      python313
      sqlite
      sqlitebrowser
      xclip
      uv
    ];
  };
}
