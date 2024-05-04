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
    autosuggestions.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake";
      compose = "sudo docker compose";
      wolpc = "wakeonlan D8:5E:D3:A8:B1:0";
    };

    ohMyZsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    shellInit = "eval \"$(zoxide init zsh --cmd cd)\"";
  };
}
