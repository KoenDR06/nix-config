#!/bin/sh

strength=$(($(iwconfig wlo1 | grep 'Link Quality' | sed -r 's/.*?Link Quality=(.*?)\/.*$/\1/')))
lines=$(($(iwconfig wlo1 | grep 'Link Quality' | sed -r 's/.*?Link Quality=(.*?)\/.*$/\1/' | wc -l)))

if (( $lines == 0 )); then
  echo 'images/wifi-off.svg'
  exit 0
fi

if (( $strength < 18 )); then
  echo 'images/wifi-1.svg'
  exit 0
fi

if (( $strength < 35 )); then
  echo 'images/wifi-2.svg'
  exit 0
fi

if (( $strength < 53 )); then
  echo 'images/wifi-3.svg'
  exit 0
fi

if (( $strength < 70 )); then
  echo 'images/wifi-4.svg'
  exit 0
fi

