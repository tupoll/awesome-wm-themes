#!/usr/local/bin/zsh


mkdir -p ~/tmp/avplay/players/
DIR2=~/tmp/avplay/players
cat ~/tmp/playlist1 |sort -r>~/tmp/avplay/playlist
head -n 1 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name


cat ~/tmp/avplay/playlist |sed '1,2d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist1
head -n 2 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name

A=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print $0}')
cp $A $DIR2/1
avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name

cat ~/tmp/avplay/playlist |sed '1,3d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist1
head -n 3 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name

B=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print $0}')
cp $B $DIR2/1
avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name

~/.config/awesome/compact/avplay/dr/play0.sh
