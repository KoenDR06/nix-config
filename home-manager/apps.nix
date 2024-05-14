{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

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
    gimp
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
    retext
    solaar
    spotify
    thunderbird
    whatsapp-for-linux
    zsh
    zoxide
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
