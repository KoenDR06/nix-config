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
    ethtool
    file
    fzf
    gcc
    ghex
    gnome-calculator
    gnupg
    haskell.compiler.native-bignum.ghcHEAD
    haskell-language-server
    htop
    icu
    jdk
    jetbrains.clion
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.rider
    jetbrains.webstorm
    inkscape
    inotify-tools
    keepassxc
    krita
    libreoffice
    lsix
    mullvad-vpn
    neofetch
    nodejs_22
    obsidian
    parsec-bin
    platformio-core
    python313
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
    unityhub
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
