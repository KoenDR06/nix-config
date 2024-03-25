#!bin/bash

cd /home/horseman/nix-config
git pull
sudo nixos-rebuild switch --flake .#laptop-koen
exit 0
