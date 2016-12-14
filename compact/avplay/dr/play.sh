#!/usr/local/bin/zsh
DIR1=~/Музыка
mkdir -p ~/tmp/avplay/players/
DIR2=~/tmp/avplay/players
find $DIR1 -name '*.mp3' -user tupoll -print | sort -u>~/tmp/avplay/playlist
cat ~/tmp/avplay/playlist |sed '1,3d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
head -n 1 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name
A=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print $0}')
cp  $A $DIR2/1


avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name
head -n 2 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name
B=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print $0}')
cp  $B $DIR2/1

avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name

head -n 3 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name
C=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print $0}')
cp  $C $DIR2/1
avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name
~/.config/awesome/compact/avplay/dr/play1.sh
