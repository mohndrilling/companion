#!/bin/bash
cd /home/pi/companion

echo 'validating archive'
if unzip -l $1 | grep -q companion/.git; then
    echo 'archive validated ok'
else
    echo 'Archive does not look like a companion update!'
    exit 1
fi

echo 'adding lock' >> /home/pi/.update_log
touch /home/pi/.updating

echo 'removing old stash'
rm -rf /home/pi/.companion

echo 'stashing repository'
mv /home/pi/companion /home/pi/.companion

echo 'extracting archive' >> /home/pi/.update_log
echo 'extracting archive: ' $1
unzip -q $1 -d /home/pi

echo 'running post-sideload.sh'
/home/pi/companion/scripts/post-sideload.sh
