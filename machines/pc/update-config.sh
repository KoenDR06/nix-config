#!bin/bash

cd /home/horseman/nix-config
git pull
sudo nixos-rebuild switch --flake .#pc-koen
exit 0
