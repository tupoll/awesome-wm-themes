#!/usr/local/bin/zsh

rm -r ~/tmp/avplay
find ~/media/music -name '*.flac' -user tupoll -print | sort -u>~/tmp/playlist
notify-send "Плэйлист .flac готов"
