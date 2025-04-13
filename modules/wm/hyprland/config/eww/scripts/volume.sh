#!/bin/sh

volume=$(($(wpctl get-volume @DEFAULT_SINK@ | sed -r 's/Volume: (0|1)\.(..)/\1\2/; s/^(0)//g')))

if (( $volume == 0 )); then
  echo 'images/sound-off.svg'
  exit 0
fi

if (( $volume < 20 )); then
  echo 'images/sound-lo.svg'
  exit 0
fi

echo 'images/sound-hi.svg'
