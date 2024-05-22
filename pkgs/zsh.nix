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
      update = "sudo nixos-rebuild switch --flake";
      compose = "sudo docker compose";
      wolpc = "wakeonlan D8:5E:D3:A8:B1:0";
      capture-config = "nix run github:pjones/plasma-manager > ~/nix-config/home-manager/plasma-conf.txt"
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "zsh-interactive-cd"
        "python"
        "git-auto-fetch"
      ];
      theme = "agnoster";
    };

    # shellInit = "if [[ $(tty) == \"/dev/tty\"* ]]; then; bash; fi";
  };
}
