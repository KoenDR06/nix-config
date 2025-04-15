{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
    ../../modules
  ];

  horseman.username = "horseman";

  networking = {
    hostName = "solis";
    firewall.allowedTCPPorts = [80 443];
  };

  system.stateVersion = "24.11";
}
