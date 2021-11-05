#!/usr/local/bin/lua52
function start() os.execute("play --vol 0.08 /home/$USER/tmp/sox/players/*.* rate -v 48000 bass +10 treble +15") end
function stop() os.execute("pkill -f play") end
start()
stop()
