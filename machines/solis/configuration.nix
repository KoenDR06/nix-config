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

  networking.hostName = "solis";

  networking.firewall.allowedTCPPorts = [3000 3001];

  system.stateVersion = "24.11";
}
