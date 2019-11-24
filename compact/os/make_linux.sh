#!/usr/bin/env bash

DIR1=~/.config/awesome/compact/
DIR2=~/.config/awesome/themes/gentoo
DIR3=~/.config/awesome

S="${DIR1}/mixer/"
A="${DIR1}/memory/"
B="${DIR1}/middle/"
C="${DIR1}/mount/"

perl -i.bk -nle'/compact.mixer.mixer_volume/||print' "${S}/init.lua"
sed -i '6a local volume  = require("compact.mixer.volume_alsa")' "${S}/init.lua"
cp -f $DIR2/rc.lua $DIR3/rc.lua
cp -f $DIR2/clock.lua $DIR1/clock.lua
perl -i.bk -nle'/compact.memory.memory_bsd/||print' "${A}/init.lua"
sed -i '3a local memory  = require("compact.memory.memory_linux")' "${A}/init.lua"
perl -i.bk -nle'/os/||print' "${B}/init.lua"
perl -i.bk -nle'/df/||print' "${C}/init.lua"
perl -i.bk -nle'/hammer2/||print' "${C}/init.lua"
perl -i.bk -nle'/zfs/||print' "${C}/init.lua"
sed -i '2a df = require("compact.mount.df")' "${C}/init.lua"
awesome -r