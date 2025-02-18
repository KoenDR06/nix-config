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

    histSize = 10000;

    shellAliases = {
      clone-dotfiles = "cp -r /home/horseman/nix-config/config/dotfiles/.\* /home/horseman/";
      rebuild = "clone-dotfiles && sudo nixos-rebuild switch --flake";
      update = "sudo nix flake update && rebuild";
      compose = "sudo docker compose";
      wolpc = "wakeonlan D8:5E:D3:A8:B1:0A";
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
