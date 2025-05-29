#!/run/current-system/sw/bin/zsh

# Documents
cd /home/horseman
tar -cf backups/documents.tar Documents

# Vaultwarden
cd /home/horseman
tar -cf backups/vaultwarden.tar docker/vaulwarden/data

exit 0
