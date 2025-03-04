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
    ../../modules/boot/loader/grub.nix
  ];

  config.horseman = {
    users.default.enable = true;

    base = {
      nix.enable = true;
      locale.enable = true;
    };

    boot = {
      loader.grub.enable = true;
    };

    network = {
      mullvad.enable = true;
      ssh.enable = true;
      syncthing.enable = true;
      tailscale.enable = true;
    };

    apps = {
      terminal.enable = true;
    };

    terminal = {
      zsh.enable = true;
    };

    timers = {
      backup.enable = true;
    };
  };
}
