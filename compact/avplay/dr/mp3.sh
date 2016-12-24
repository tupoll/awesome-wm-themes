#!/usr/local/bin/zsh

rm -rf ~/tmp/playlist1
rm -r ~/tmp/avplay
find ~/Музыка -name '*.mp3' -user tupoll -print | sort -u>~/tmp/playlist
touch ~/tmp/playlist1
notify-send "Плэйлист .mp3 готов"
