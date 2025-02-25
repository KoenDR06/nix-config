{inputs, ...}: {
  imports = [
    ./mullvad.nix
    ./ssh.nix
    ./syncthing.nix
    ./tailscale.nix
  ];
}
