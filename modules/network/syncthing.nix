{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.horseman.network.syncthing;
in {
  options = {
    horseman.network.syncthing = {
      enable = mkEnableOption "";
    };
  };

  config = {
    services.syncthing = {
      enable = true;
      user = "horseman";
      dataDir = "/home/horseman";
      configDir = "/home/horseman/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        options = {
          urAccepted = -1;
        };
        devices = {
          "luna" = {
            id = "MW4ZTAX-D7KDLRL-YHNGNCF-V6FW5L4-SCKQKES-BO7KV43-L5667GL-JHIYEAA";
            autoAcceptFolders = true;
            name = "luna";
          };
          "terra" = {
            id = "2QWRFLY-ZUY5C6C-X36R5CY-PJSGLYY-5HWIWJN-2YYWRPU-T66GJMU-GXTQ6QK";
            autoAcceptFolders = true;
            name = "terra";
          };
          "solis" = {
            id = "YOSYADZ-3OZ3XBH-7XEIK2W-DHAEIFD-5P5ZIHB-PAP74DH-T7GHLKT-O32YEA4";
            autoAcceptFolders = true;
            name = "solis";
          };
        };
        folders = {
          "Documents" = {
            id = "documentFolder";
            path = "/home/horseman/Documents";
            devices = ["luna" "terra" "solis"];
          };
        };
      };
    };
    networking.firewall.allowedUDPPorts = [22000 21027];
    networking.firewall.allowedTCPPorts = [8384 22000];
  };
}
