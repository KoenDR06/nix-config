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


  networking.hostName = "luna";

  system.stateVersion = "24.11";
}
