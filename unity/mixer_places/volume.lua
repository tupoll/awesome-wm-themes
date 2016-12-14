--local iconic = require('iconic')
local wibox = require('wibox')
local naughty = require('naughty')
local utility = require('utility')
local awful = require("awful")


local volume = {}

local function keymap(...)
   local t = {}
   for _, k in ipairs({...}) do
      local but
      if type(k[1]) == "table" then
         but = awful.button(k[1], k[2], k[3])
      else
         but = awful.button({}, k[1], k[2])
      end
      t = awful.util.table.join(t, but)
   end
   return t
end
local mouse = { LEFT = 1, MIDDLE = 2, RIGHT = 3, WHEEL_UP = 4, WHEEL_DOWN = 5 }

function volume.inc()
    os.execute("mixer vol +5") 
end

function volume.dec()
    os.execute("mixer vol -5")
end

function volume.mute(w)
    os.execute("mixer vol 0")
end

function volume.new()

   local w = wibox.widget.textbox()
   w:set_text(awful.util.pread(
   " /usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1"  
)) 
   w:set_align("center")
   w:set_valign("center")
   w.fit = function() return 1,35 end 
   w.inc = volume.inc
   w.dec = volume.dec
   w.mute = volume.mute
 
  volumetimer = timer(
   { timeout = 0.1 ,hover_timeout = 0.1} -- Update every 15 minutes timeout = 1 0.5
)
volumetimer:connect_signal(
   "timeout", function()
      w:set_text(awful.util.pread(
         "/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1"
      ))end)

volumetimer:start() -- Start the timer
w:connect_signal(
   "mouse::enter", function()
       volume = naughty.notify(
         {title="ГРОМКОСТЬ",text=awful.util.pread("/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1&& /usr/sbin/mixer bass|/usr/bin/awk '{print $2}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer bass|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer treble|/usr/bin/awk '{print $2}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer treble|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1") ,
          position      =  "bottom_right",
         -- timeout = 1, hover_timeout = 0.5,
          width = 80
  })  
end)
w:connect_signal(
   "mouse::leave", function()
      naughty.destroy(volume)
end)

  -- remove_mixer()
 local function notify_volume() 
   local naughty = naughty.notify({text = string.format('%s',"ohsnap", "mixer"),
     timeout = 0.1, hover_timeout = 0.1,
     width = 220
   }) 
end 
      w:buttons(
      keymap({ mouse.LEFT, function() w:mute() end },
             { mouse.WHEEL_UP, function() w:inc() end },
             { mouse.WHEEL_DOWN, function() w:dec() end }))
   return w
end



return setmetatable(volume, { __call = function(_, ...) return volume.new(...) end})
