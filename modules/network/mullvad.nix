{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.network.mullvad;
in {
  options = {
    horseman.network.mullvad = {
      enable = mkEnableOption "Enables the Mullvad VPN";
    };
  };

  config = mkIf cfg.enable {
    services = {
      mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
      };
      resolved = {
        enable = true;
        dnssec = "true";
        domains = ["~."];
        fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
      };
    };
    networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  };
}
