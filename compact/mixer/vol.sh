#!/usr/local/bin/zsh
/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1
