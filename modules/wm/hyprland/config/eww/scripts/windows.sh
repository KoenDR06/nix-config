#!/bin/sh

if [ $(hyprctl -j clients | jq '.[].workspace.id' | grep -w $1 | wc -l) -eq 0 ]; then
  echo "⬦"
else 
  echo "⟐"
fi
