{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.hardware.audio;
in {
  options = {
    horseman.hardware.audio = {
      enable = mkEnableOption "";
    };
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    services.jack = {
      jackd.enable = false;
      alsa.enable = true;
      loopback.enable = false;
    };
    users.extraUsers.horseman.extraGroups = ["jackaudio"];
  };
}
