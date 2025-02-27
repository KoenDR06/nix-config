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
  ];

  networking.hostName = "luna";

  system.stateVersion = "24.11";
}
