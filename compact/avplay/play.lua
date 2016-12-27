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
  
 function next()
    os.execute("~/.config/awesome/compact/avplay/dr/play.sh &")
end
    
  function stop()
    os.execute("~/.config/awesome/compact/avplay/dr/stop.sh")
end
   
   local function play()
    os.execute("~/.config/awesome/compact/avplay/dr/play1.sh &")
end   
    
    local pl = wibox.widget.imagebox()
    pl_next=next
    pl:set_image(icons.."repeat.png")
        
    local ff = wibox.widget.imagebox()
    ff_forward=forward
    ff:set_image(icons.."next.png")
   
    local av = wibox.widget.imagebox()
    av_play=play
    av:set_image(icons.."play.png")

    local st = wibox.widget.imagebox()
    st_stop=stop
    st:set_image(icons.."stop.png")   
   
    widgets_table["imagebox"]	= av, pl, st, ff 
    if widget then	    
	    widget:add(pl)
        widget:add(st)
        widget:add(av)
        widget:add(ff)     
    end 
   
   local function playlist_update()
   playlist_now  = awful.util.pread("cat ~/tmp/avplay/name | cut -c21-100 ")
   playlist_next = awful.util.pread("cat ~/tmp/playlist | cut -c21-100 ")
   playlist_past = awful.util.pread("cat ~/tmp/playlist1 | cut -c21-100 | sed -e :a -e '$q;N;25,$D;ba'")
   end
 
    local playlist_timer = timer({ timeout = timeout })
    playlist_update()
    playlist_timer:connect_signal("timeout", playlist_update)
    playlist_timer:start()
     
    local naughty_timer = timer({ timeout = 1.1})
     
    
   local function notify_avplay()
         n = naughty.notify({ title="Проигранное:" ..playlist_past .."-----------------------------------Играет---------------------------------------",
                              text= playlist_now.. "--------------------------------------------------------------------------------".. "Следующая:" ..playlist_next,                                                           
                              position      =  "bottom_left",                                                                 
                              timeout = 100, 
                              width = 650                            
                              })end

    local duble       = require('naughty')
    local function notify_avplay_d()
         d = duble.notify({ title="Проигранное:" ..playlist_past .."-----------------------------------Играет---------------------------------------",
                              text= playlist_now.. "--------------------------------------------------------------------------------".. "Следующая:" ..playlist_next,                                                           
                              position      =  "bottom_left",                                                                 
                              timeout = 1, 
                              width = 650                            
                              })end

 local duble_timer = timer({ timeout = 0.8 })
 duble_timer:connect_signal("timeout" ,notify_avplay_d)
widget:connect_signal("mouse::leave", function()duble_timer:stop(d)end)
widget:connect_signal("mouse::leave", function()naughty.destroy(n)end)
widget:connect_signal("mouse::enter", function()notify_avplay(n)end) 

      av:buttons(
      keymap({ mouse.LEFT, function() av_play() end },
      { mouse.LEFT, function()naughty.destroy(n)end },
      { mouse.LEFT, function()duble_timer:start(d)end }))
    
      st:buttons(
      keymap({ mouse.LEFT, function() st_stop() end },
      { mouse.LEFT, function()naughty.destroy(n)end },
      { mouse.LEFT, function()duble_timer:stop(d)end }))
      
      
      ff:buttons(
      keymap({ mouse.LEFT, function() ff_forward() end },
      { mouse.LEFT, function()naughty.destroy(n)end },
      { mouse.LEFT, function()duble_timer:start(d)end }))
      
      
      
      pl:buttons(
      keymap({ mouse.LEFT, function()  pl_next() end  },     
      { mouse.LEFT, function()naughty.destroy(n)end },
      { mouse.LEFT, function()duble_timer:start(d)end }))
      
      
      return widget
  end  
       
return setmetatable(avplay, {__call = function(_,...) return worker(...) end})
