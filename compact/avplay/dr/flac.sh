rm -r ~/tmp/avplay
find ~/Музыка -name '*.flac' -user tupoll -print | sort -u>~/tmp/playlist
notify-send "Плэйлист .flac готов"
