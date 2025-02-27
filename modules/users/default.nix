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

  config = {
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
