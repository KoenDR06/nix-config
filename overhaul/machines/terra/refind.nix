{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.refind
    pkgs.efibootmgr
  ];
}
