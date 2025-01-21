#!/run/current-system/sw/bin/zsh

cd /home/horseman
file=backups/$(date +%Y-%m-%d).tar
tar -cf $file Documents

if grep -q $(sha256sum $file) backups/sum; then
    echo 'hashes match, quitting'
    rm $file
    exit 0
fi

echo $(sha256sum ) > backups/sum
