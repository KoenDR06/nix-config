{
  inputs,
  headless,
  ...
}: {
  imports = [
    ./apps
    ./hardware
    ./network
    ./terminal
    ./wm
    ./users
    ./boot
    ./base
    ./username.nix
  ];
}
