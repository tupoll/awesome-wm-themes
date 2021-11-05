#!/usr/local/bin/zsh

mkdir -p ~/tmp/sox/players/
DIR2=~/tmp/sox/players
cat ~/tmp/playlist1 |sort -r>~/tmp/sox/playlist
head -n 1 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
cat ~/tmp/sox/playlist |sed '1d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist1
head -n 2 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
A=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
cp $A $DIR2
~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
mkdir -p $DIR2
cat ~/tmp/sox/playlist |sed '1,2d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist1
head -n 1 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
B=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
cp $B $DIR2
~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
mkdir -p $DIR2
cat ~/tmp/sox/playlist |sed '1,3d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist1
head -n 3 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
C=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
cp $C $DIR2
~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
mkdir -p $DIR2

~/.config/awesome/compact/sox/drivers/play2.sh
