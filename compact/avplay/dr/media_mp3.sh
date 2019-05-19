#!/bin/zsh

rm -rf ~/tmp/playlist1
rm -r ~/tmp/avplay
find ~/media/music -name '*.mp3' -user tupoll -print | sort -u>~/tmp/playlist
touch ~/tmp/playlist1
chmod +x ~/tmp/playlist ~/tmp/playlist1
notify-send "Плэйлист .mp3 готов"
