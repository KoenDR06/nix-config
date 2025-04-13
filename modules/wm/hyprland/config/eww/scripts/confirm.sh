#!/bin/sh

read -t 10 -p "Are you sure? Doing it anyway in 10 seconds" input

if [ $(($?)) = 0 ]; then
  $1
fi
