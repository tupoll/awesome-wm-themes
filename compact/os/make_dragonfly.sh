#!/usr/bin/env bash

DIR1=~/.config/awesome/
DIR2=~/.config/awesome/compact/
DIR3=~/.config/awesome/themes/dragonfly

A="${DIR2}/right/"
B="${DIR2}/middle/"

cp -f $DIR3/rc.lua $DIR1/rc.lua
perl -i.bk -nle'/compact.net.net_vicious/||print' "${A}/init.lua"
sed -i '5a local n    = require("compact.net.net_dragonfly")' "${A}/init.lua"
perl -i.bk -nle'/os/||print' "${B}/init.lua"
