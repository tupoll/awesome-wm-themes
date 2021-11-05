#!/usr/local/bin/lua52
--[[
by tupoll for freebsd.
--]]
local a =('rm -rf ~/tmp/playlist1\n')
local c =("find ~/Музыка -name '*.mp3' -user tupoll -print | sort -u>~/tmp/playlist\n")
local b = ('rm -rf ~/tmp/sox\n')
local d = ("touch ~/tmp/playlist1\n")
local e = ("chmod +x ~/tmp/playlist ~/tmp/playlist1\n")
local f = ("notify-send 'Плэйлист для sox готов'")
local h = ("find ~/Музыка -name '*.flac' -user tupoll -print | sort -u>>~/tmp/playlist\n")
local j = ("find ~/Музыка -name '*.ape' -user tupoll -print | sort -u>>~/tmp/playlist\n")
playlist = io.open("/tmp/playlist", "w")
playlist:write(a, b, c, h, j, d, e, f)
playlist:close()
os.execute("chmod 755 /tmp/playlist")
os.execute("/tmp/playlist")
os.execute("rm -f /tmp/playlist")
