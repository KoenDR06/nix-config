{inputs, headless, ...}: {
  imports = [
    ./apps
    ./hardware
    ./network
    ./terminal
    ( if !headless then ./wm else ./empty.nix )
    ./users
    ./boot
    ./base
    ./username.nix
  ];
}
