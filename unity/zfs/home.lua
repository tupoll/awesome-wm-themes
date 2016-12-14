local beautiful   = require("beautiful")
local wibox = require('wibox')
local naughty = require('naughty')
local awful = require("awful")
local df = {}
local devnull = ">/dev/null"

local home = {}

function home.new()

   local w = wibox.widget.textbox()
   w:set_text(awful.util.pread("df /home|/usr/bin/awk '{print $5}' | sed '1d'"))
   
   dftimer = timer({ timeout = 1 ,hover_timeout = 0.5})     -- Update every 15 minutes.
   dftimer:connect_signal(
   "timeout", function()
      w:set_text(awful.util.pread("df /home|/usr/bin/awk '{print $5}' | sed '1d'"))
      end)

  dftimer:start() -- Start the timer
    w:connect_signal(
   "mouse::enter", function()
      home = naughty.notify(
         {title="ЗАНЯТО НА RAID",text=awful.util.pread("df  /home|/usr/bin/awk  '{print $1,$5}' | sed '1d' | cut -c9-18 && df /|/usr/bin/awk '{print $6,$5}'| sed '1d' && echo СТАТУС && zpool status |/usr/bin/awk '{print $1,$2}'| sed '5,11d'") ,
        timeout = 0, hover_timeout = 0.5,
     position      =  "bottom_right",
     width = 150
  })  
end) -- this creates the hover feature.


   w:connect_signal(
   "mouse::leave", function()
      naughty.destroy(home)
end)
  return w
 end

return setmetatable(home, { __call = function(_, ...) return home.new(...) end})

