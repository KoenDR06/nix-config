{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.users.default;
  homeCfg = config.horseman;
in {
  options = {
    horseman.users.default = {
      enable = mkEnableOption "Default user";
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {inherit inputs outputs;};
      users.${homeCfg.username} = {
        home = {
          username = "${homeCfg.username}";
          homeDirectory = "/home/${homeCfg.username}";
          stateVersion = "24.11";
        };

        programs = {
          home-manager.enable = true;

          gh.enable = true;
          git = {
            enable = true;
            userName = "KoenDR06";
            userEmail = "koen.de.ruiter@hotmail.com";
          };
        };
      };
    };

    users.users.horseman = {
      initialPassword = "1234";
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [
        ../../config/ssh/authorized_keys
      ];
      extraGroups = [
        "wheel"
        "docker"
      ];
    };
  };
}
