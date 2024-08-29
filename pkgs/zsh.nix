{
  config,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      wd = "wd --config ~/nix-config/config/.warprc";
      rebuild = "sudo nixos-rebuild switch --flake";
      update = "sudo nix flake update && rebuild";
      compose = "sudo docker compose";
      wolpc = config.sops.templates."zshwolpc".content;
      capture-config = "nix run github:pjones/plasma-manager > ~/nix-config/home-manager/plasma.nix";
      reboot-to-windows = "sudo efibootmgr -n 0000";
      mkdir = "mkdir -p";
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "zsh-interactive-cd"
        "python"
        "git-auto-fetch"
        "wd"
      ];
      custom = "/home/horseman/nix-config/pkgs/zsh/";
      theme = "jonathan";
    };

    shellInit = "eval \"$(direnv hook zsh)\"";
  };
}
