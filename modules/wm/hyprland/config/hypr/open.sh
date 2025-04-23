#!/bin/sh

(pkill wofi && ~/.config/eww/scripts/close.sh) || 
  (wofi --show drun &
  ~/.config/eww/scripts/open.sh)
