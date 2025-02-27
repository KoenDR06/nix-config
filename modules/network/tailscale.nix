{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.network.tailscale;
in {
  options = {
    horseman.network.tailscale = {
      enable = mkEnableOption "Enable the Tailscale VPN service";
    };
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
