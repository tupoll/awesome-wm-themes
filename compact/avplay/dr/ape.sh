#!/bin/zsh

rm -r ~/tmp/avplay
find ~/Музыка -name '*.ape' -user tupoll -print | sort -u>~/tmp/playlist
notify-send "Плэйлист .ape готов"
