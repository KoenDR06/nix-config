#!/bin/sh

eww update hostname="$(hostname)"

eww open-many --toggle quote quicksettings appbar fetch sys
