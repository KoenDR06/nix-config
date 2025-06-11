{inputs, ...}: {
  imports = [
    ./greeter/sddm.nix
    ./greeter/gdm.nix
    ./greeter/cosmic.nix

    ./refind.nix

    ./loader/grub.nix
    ./loader/systemd.nix
  ];
}
