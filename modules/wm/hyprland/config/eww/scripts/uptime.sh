#!/bin/sh

uptime=$(($(date +%s) - $(date +%s -d "$(last reboot | head -n 1 | sed -e 's/reboot   system boot  ......           //; s/still running//')")));

echo $((uptime / 3600 % 60))h $((uptime / 60 % 60))m
