{inputs, ...}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./gpu/nvidia.nix
    ./wifi.nix
  ];
}
