{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules
    ../../modules/boot/loader/systemd.nix
  ];

  config.horseman = {
    users.default.enable = true;

    base = {
      nix.enable = true;
      locale.enable = true;
    };

    boot = {
      loader.systemd.enable = true;
      greeter.sddm.enable = true;
      refind.enable = true;
    };

    wm = {
      plasma.enable = true;
    };

    hardware = {
      gpu.nvidia.enable = true;
      audio.enable = true;
    };

    network = {
      mullvad.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      tailscale.enable = true;
    };

    apps = {
      dev.enable = true;
      visual.enable = true;
      terminal.enable = true;
    };
  };
}
