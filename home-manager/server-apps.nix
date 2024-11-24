{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nvim/neovim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "horseman";
    homeDirectory = "/home/horseman";
  };

  home.packages = with pkgs; [
    busybox
    direnv
    docker-compose
    fzf
    gcc
    gnupg
    htop
    jdk
    python3
    sops
    tailscale
    tmux
    unzip
    wakeonlan
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "KoenDR06";
    userEmail = "koen.de.ruiter@hotmail.com";
  };

  programs.gh.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
