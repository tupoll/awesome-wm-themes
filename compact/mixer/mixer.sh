#!/usr/local/bin/zsh

/usr/sbin/mixer vol|/usr/bin/awk '{print "ГРОМКОСТЬ ... " $7}'|/usr/bin/cut -d: -f1

/usr/sbin/mixer bass|/usr/bin/awk '{print "BASS ........ " $7}'|/usr/bin/cut -d: -f1

/usr/sbin/mixer treble|/usr/bin/awk '{print "TREBLE ...... " $7}'|/usr/bin/cut -d: -f1
