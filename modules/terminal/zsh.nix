{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.terminal.zsh;
in {
  options = {
    horseman.terminal.zsh = {
      enable = mkEnableOption "The ZSH shell and plugins for it";
    };
  };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [zsh];

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      histSize = 10000;

      shellAliases = {
        clone-dotfiles = "cp -r /home/horseman/nix-config/config/dotfiles/.\* /home/horseman/";
        rebuild = "function _rebuild(){clone-dotfiles && sudo nixos-rebuild switch --flake \"$@\" && nix fmt}; _rebuild";
        update = "sudo nix flake update && rebuild";
        compose = "sudo docker compose";
        wolpc = "wakeonlan D8:5E:D3:A8:B1:0A";
        capture-config = "nix run github:pjones/plasma-manager > ~/nix-config/modules/wm/plasma/default.nix";
        reboot-to-windows = "sudo efibootmgr -n 0000";
        mkdir = "mkdir -p";
        l = "ls -lAh --group-directories-first";
        zip = "zip -r";
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
        theme = "jonathan";
      };

      shellInit = "eval \"$(direnv hook zsh)\"";
    };
  };
}
