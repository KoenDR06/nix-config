{
  inputs,
  headless,
  ...
}: {
  imports = [
    ./greeter/sddm.nix
    ./refind.nix

    ./loader/grub.nix
    ./loader/systemd.nix
  ];
}
