#!/usr/local/bin/zsh

DIR2=~/tmp/sox/players
mkdir -p $DIR2
cp -R ~/tmp/playlist ~/tmp/sox/playlist
cat ~/tmp/sox/playlist |sed '1d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
head -n 1 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
cat ~/tmp/sox/name>>~/tmp/playlist1
A=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
cp $A $DIR2
~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
mkdir -p $DIR2
cat ~/tmp/sox/playlist |sed '1,2d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
head -n 2 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
cat ~/tmp/sox/name>>~/tmp/playlist1
B=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
cp $B $DIR2
~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
cat ~/tmp/sox/playlist |sed '1,3d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
head -n 3 ~/tmp/sox/playlist | tail -n1 >~/tmp/sox/name
cat ~/tmp/sox/name>>~/tmp/playlist1
C=$(cat ~/tmp/sox/name |  /usr/bin/awk '{print $0}')
mkdir -p $DIR2
cp  $C $DIR2

~/.config/awesome/compact/sox/drivers/start.lua
rm -rf $DIR2
rm -rf ~/tmp/sox/name
~/.config/awesome/compact/sox/drivers/play.sh
