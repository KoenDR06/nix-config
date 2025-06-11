{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.apps.terminal;
  homeCfg = config.horseman;
in {
  options = {
    horseman.apps.terminal = {
      enable = mkEnableOption "Apps that run only in terminal without a GUI";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${homeCfg.username} = {
      imports = [./terminal/helix.nix];
    };

    services.lorri.enable = true;

    environment.systemPackages = with pkgs; [
      bat
      direnv
      docker-compose
      ethtool
      file
      fzf
      gcc
      btop
      gnupg
      neofetch
      nodejs_22
      sops
      sxiv
      termdown
      tmux
      unzip
      wakeonlan
      zip
    ];

    environment.sessionVariables = rec {
      TERM = "kitty";
    };

    # Docker
    virtualisation.docker.enable = true;
  };
}
