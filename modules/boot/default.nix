{inputs, headless, ...}: {
  imports = [
    ./greeter/sddm.nix
    ./refind.nix

    ( if headless then ./loader/grub.nix else ./loader/systemd.nix )
  ];
}
