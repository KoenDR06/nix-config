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
  
  # Enable programs
  home.packages = with pkgs; [    
    bitwarden
    discord
    docker-compose
    fzf
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jdk
    gcc
    gimp
    gnome.gnome-calculator
    gnupg
    htop
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
    unzip
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
