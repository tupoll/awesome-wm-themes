#!/usr/local/bin/zsh

 ps  | grep -E avplay| /usr/bin/awk '{print $1}'| tr -s '\r\n' ' ' |/usr/bin/awk '{print "kill " $0}'>~/tmp/stop.sh   
chmod +x ~/tmp/stop.sh
~/tmp/stop.sh 


exit 0
