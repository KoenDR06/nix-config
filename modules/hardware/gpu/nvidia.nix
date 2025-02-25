{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.hardware.gpu.nvidia;
in {
  options = {
    horseman.hardware.gpu.nvidia = {
      enable = mkEnableOption "Enable support for NVIDIA GPUs";
    };
  };

  config = {
    hardware.graphics.enable32Bit = true;
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
