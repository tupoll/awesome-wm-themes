#!/usr/local/bin/lua52

local a =('rm -rf ~/tmp/playlist1\n')
local b = ('rm -rf ~/tmp/sox\n')
local c = ("touch ~/tmp/playlist1\n")
local d =('rm -rf ~/tmp/playlist')

playlist = io.open("/tmp/playlist", "w")
playlist:write(a, b, c, d)
playlist:close()
os.execute("chmod 755 /tmp/playlist")
os.execute("/tmp/playlist")
os.execute("rm -f /tmp/playlist")
os.execute("thunar ~/Музыка") --echo -n %f | /usr/bin/awk '{print $0}'>>~/tmp/playlist(cmd)
