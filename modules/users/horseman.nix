{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.users.horseman;
in {
  options = {
    horseman.users.horseman = {
      enable = mkEnableOption "Default user";
    };
  };

  config = {
    home-manager = {
      extraSpecialArgs = {inherit inputs outputs;};
      users.horseman = {
        home.stateVersion = "24.11";
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
