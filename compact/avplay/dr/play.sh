#!/usr/local/bin/zsh

DIR1=~/Музыка
mkdir -p ~/tmp/avplay/players/
DIR2=~/tmp/avplay/players
ls $DIR1>~/tmp/avplay/playlist
#sed '/./=' ~/tmp/avplay/playlist1 | sed '/./N; s/\n/ /'>~/tmp/avplay/playlist

P=~/tmp/avplay/playlist
cat ~/tmp/avplay/playlist |sed '1,2d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
#B=$(cat $P |/usr/bin/awk '{print"/" $1}'|head -n 1  | tail -n1)   #>~/tmp/avplay/rename
#C=$(cat $P |sed '1d'|  /usr/bin/awk '{print"/" $1}'|head -n 1  | tail -n1)   #>~/tmp/avplay/rename1
head -n 1 ~/tmp/avplay/playlist | tail -n1 >~/tmp/avplay/name
A=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print"/" $0}')

cp -R $DIR1$A $DIR2
cd $DIR2 &&  x=1; for i in *.mp3 ; do mv $i $x;x=$(($x+1)); done

avplay -autoexit -nodisp $DIR2/1 
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name
head -n 2 $P | tail -n1 >~/tmp/avplay/name
D=$(cat ~/tmp/avplay/name |  /usr/bin/awk '{print"/" $0}')
cp -R $DIR1$D $DIR2
cd $DIR2 &&  x=1; for i in *.mp3 ; do mv $i $x;x=$(($x+1)); done
avplay -autoexit -nodisp $DIR2/1
cat $P |sed '1,2d'|  /usr/bin/awk '{print $0}'>~/tmp/playlist
rm -rf ~/tmp/avplay/players/1
rm -rf ~/tmp/avplay/name
rm -rf ~/tmp/avplay/playlist
~/play1.sh
