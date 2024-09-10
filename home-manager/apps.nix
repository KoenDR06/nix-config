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

  home.packages = with pkgs; [
    bitwarden
    direnv
    discord-ptb
    docker-compose
    dotnetCorePackages.dotnet_9.runtime
    dotnetCorePackages.dotnet_9.sdk
    file
    fzf
    gimp
    gnome-calculator
    gnupg
    htop
    jdk
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.rider
    inkscape
    inotify-tools
    libreoffice
    mono5
    mullvad-vpn
    neofetch
    obsidian
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
    wakeonlan
    whatsapp-for-linux
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
