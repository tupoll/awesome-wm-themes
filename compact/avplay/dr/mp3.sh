#!/usr/local/bin/zsh

rm -r ~/tmp/avplay
find ~/Музыка -name '*.mp3' -user tupoll -print | sort -u>~/tmp/playlist
notify-send "Плэйлист .mp3 готов"
