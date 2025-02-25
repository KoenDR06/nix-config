{inputs, ...}: {
  imports = [
    ./loader/systemd.nix
    ./greeter/sddm.nix
  ];
}
