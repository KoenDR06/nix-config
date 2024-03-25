#!/bin/bash

cd /home/horseman/nix-config

cp -r nixos machines/pc

git add *
git commit *
git push
