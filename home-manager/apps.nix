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

  home.packages = with pkgs; [
    alacritty
    bitwarden
    direnv
    discord-ptb
    docker-compose
    dotnetCorePackages.sdk_8_0_1xx
    dotnetPackages.Nuget
    file
    fzf
    gcc
    ghex
    gimp
    gnome-calculator
    gnupg
    htop
    icu
    jdk
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.webstorm
    inkscape
    inotify-tools
    libreoffice
    lsix
    msbuild
    mullvad-vpn
    neofetch
    nodejs_22
    obsidian
    parsec-bin
    platformio-core
    python3
    python312Packages.joblib
    python312Packages.numpy
    python312Packages.scikit-learn
    python312Packages.scipy
    python312Packages.threadpoolctl
    qbittorrent
    reaper
    retext
    solaar
    sops
    spotify
    sqlite
    sqlitebrowser
    sxiv
    termdown
    thunderbird
    tmux
    unzip
    vlc
    wakeonlan
    xclip
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
