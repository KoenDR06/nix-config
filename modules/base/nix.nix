{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.base.nix;
in {
  options = {
    horseman.base.nix = {
      enable = mkEnableOption "Standard settings for nix";
    };
  };

  config = {
    nixpkgs = {
      config.allowUnfree = true;
    };

    nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      dotnetCorePackages.sdk_9_0
    ];

    nix.nixPath = ["/etc/nix/path"];
    environment.etc =
      lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

    nix.settings.trusted-users = ["root" "horseman"];
    nix.settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
}
