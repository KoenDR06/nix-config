{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
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
  
  # Enable programs
  home.packages = with pkgs; [
    bitwarden
    discord
    jetbrains.clion
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.jdk 
    gimp
    gnome.gnome-tweaks
    gnomeExtensions.just-perfection
    htop
    inkscape
    libreoffice
    parsec-bin
    platformio-core
    spotify
    tailscale
    whatsapp-for-linux
    zoxide
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "KoenDR06"; userEmail = 
    "koen.de.ruiter@hotmail.com";
  };
  programs.firefox.enable = true;
  programs.gh.enable = true;
  programs.zsh = {
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake .#laptop-koen";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
