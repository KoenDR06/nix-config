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
    };

    ohMyZsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    shellInit = "eval \"$(zoxide init zsh --cmd cd)\"";
  };
}
