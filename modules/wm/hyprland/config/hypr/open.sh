#!/bin/sh

(pkill wofi && ~/.config/eww/scripts/open.sh) || 
  (wofi --show drun &
  ~/.config/eww/scripts/open.sh)
