#!/usr/local/bin/lua52
--[[Volume play(sox) 
by tupoll for freebsd.
default = play --vol 0.12 /home/$USER/tmp/sox/players/*.* rate -v 48000 bass +10 treble +15
--]]
local a = ("#!/usr/local/bin/lua52\n")
local b = ('function start() os.execute("play /home/$USER/tmp/sox/players/*.* rate -v 48000 bass +10 treble +15") end\n')
local c = ('function stop() os.execute("pkill -f play") end\n')
local d = ("start()\n")
local e = ("stop()")

vol = io.open(".config/awesome/compact/sox/drivers/start.lua", "w")
vol:write(a, b, c, d, e)
vol:close()
os.execute("chmod 755 .config/awesome/compact/sox/drivers/start.lua")
