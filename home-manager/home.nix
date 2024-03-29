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
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "horseman";
    homeDirectory = "/home/horseman";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  
  # Enable programs
  home.packages = with pkgs; [
    bitwarden
    discord
    jetbrains.jdk 
    jetbrains-toolbox
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
