#!/usr/bin/env bash

DIR1=~/.config/awesome/compact/
A="${DIR1}/mount"/
B="${DIR1}/middle"/
perl -i.bk -nle'/os/||print' "${B}/init.lua"
perl -i.bk -nle'/df/||print' "${A}/init.lua"
perl -i.bk -nle'/hammer2/||print' "${A}/init.lua"
perl -i.bk -nle'/zfs/||print' "${A}/init.lua"
sed -i '2a df = require("compact.mount.zfs")' "${C}/init.lua"
