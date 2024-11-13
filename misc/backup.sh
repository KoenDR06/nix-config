#!/run/current-system/sw/bin/zsh

cd /home/horseman

tar -cf backups/$(date +%Y-%m-%d).tar Documents
