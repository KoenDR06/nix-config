#!/bin/sh

cd /home/horseman

tar -cf backups/$(date +%Y-%m-%d).tar Documents
