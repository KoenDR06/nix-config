#!/bin/sh

cap=$(cat /sys/class/power_supply/BAT1/capacity)

charge=$(cat /sys/class/power_supply/BAT1/status)

[[ $charge == "Discharging" ]] && echo -$cap% || echo +$cap%
