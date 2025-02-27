{inputs, ...}: {
  imports = [
    ./dev.nix

    ./terminal.nix

    ./visual.nix
    ./visual/firefox.nix
  ];
}
