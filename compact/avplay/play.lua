local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")
local avplay = {}
local function worker(args)
    local args = args or {}

    widgets_table = {}
    local connected = false

    -- Settings
    local icons         = beautiful.path.."/avplay/"
    local interface     = args.interface or "avplay"
    local timeout       = args.timeout or 5
    local font          = args.font or beautiful.font
    local popup_signal  = args.popup_signal or false
    local onclick       = args.onclick
    local widget 	= args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 5

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

  function forward()
    os.execute("killall avplay")
end
  
 function play()
    os.execute("~/.config/awesome/compact/avplay/dr/play.sh &")
end
    
  function stop()
    os.execute("~/.config/awesome/compact/avplay/dr/stop.sh")
end

   function trac()   
   os.execute("~/.config/awesome/compact/avplay/dr/timer.sh>~/tmp/avplay/timer &")
end
 
    function next()
    os.execute("~/.config/awesome/compact/avplay/dr/play1.sh &")
end   
 
    local pl = wibox.widget.imagebox()
    pl_next=next
    pl:set_image(icons.."play.png")
        
    local ff = wibox.widget.imagebox()
    ff_forward=forward
    ff:set_image(icons.."next.png")
   
    local av = wibox.widget.imagebox()
    av_play=play, function() trac() end
    av:set_image(icons.."make.png")

    local st = wibox.widget.imagebox()
    st_stop=stop
    st:set_image(icons.."stop.png")   
   
    widgets_table["imagebox"]	= av, pl, st, ff 
    if widget then	    
	    widget:add(av)
        widget:add(pl)
        widget:add(st)
        widget:add(ff)    
        
    end 
        
      av:buttons(
      keymap({ mouse.LEFT, function() av_play() end }))
      st:buttons(
      keymap({ mouse.LEFT, function() st_stop() end }))
       
      ff:buttons(
      keymap({ mouse.LEFT, function() ff_forward() end }))
      pl:buttons(
      keymap({ mouse.LEFT, function() pl_next() end }))     

      return widget
    
end

   
   
    
    
return setmetatable(avplay, {__call = function(_,...) return worker(...) end})
