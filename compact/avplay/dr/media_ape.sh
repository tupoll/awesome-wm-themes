!#/usr/local/bin/zsh

rm -r ~/tmp/avplay
find ~/media/music -name '*.ape' -user tupoll -print | sort -u>~/tmp/playlist
notify-send "Плэйлист .ape готов"

