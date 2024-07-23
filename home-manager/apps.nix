{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./plasma.nix
    ./gnome.nix
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
    bitwarden
    discord-ptb
    docker-compose
    file
    fzf
    gimp
    gnome.gnome-calculator
    gnupg
    htop
    jdk
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    inkscape
    inotify-tools
    libreoffice
    mullvad-vpn
    neofetch
    parsec-bin
    platformio-core
    python3
    python311Packages.joblib
    python311Packages.numpy
    python311Packages.scikit-learn
    python311Packages.scipy
    python311Packages.threadpoolctl
    qbittorrent
    reaper
    retext
    solaar
    sops
    spotify
    thunderbird
    tmux
    unzip
    vlc
    whatsapp-for-linux
    youtube-dl
    zsh
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
