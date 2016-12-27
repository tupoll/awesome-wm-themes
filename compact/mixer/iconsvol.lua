local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")

local mixer_vol = {}
local function worker(args)
    local args = args or {}

    widgets_table = {}
    local connected = false

    -- Settings
    local ICON_DIR      = beautiful.path.."/mixer/"
    local interface     = args.interface or "mixer vol"
    local timeout       = args.timeout or 1
    local font          = args.font or beautiful.font   
    local widget 	= args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 3

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

  function mixer_vol.inc()
    os.execute("mixer vol +5") 
end

function mixer_vol.dec()
    os.execute("mixer vol -5")
end

function mixer_vol.mute(w)
    os.execute("mixer vol 0")
end

    local vol_icon = wibox.widget.imagebox()
    vol_icon.inc = mixer_vol.inc
    vol_icon.dec = mixer_vol.dec
    vol_icon.mute = mixer_vol.mute
    local vol_timer = timer({ timeout = timeout })
    local naughty_timer = timer({ timeout = 1.1})
    local volume_level = 0
    local bass_level   = 0
    local treble_level = 0
    
         function notify_volume()
         n = naughty.notify({ title="ГРОМКОСТЬ :" ..volume_level ,
                              text="BASS      :" ..bass_level..  "TREBLE    :" ..treble_level,                                                           
                              position      =  "bottom_right",                                                                 
                              timeout = 1, 
                              width = 120                            
                              })end
   

        local duble       = require('naughty')
        function notify_volume_d()
         d = duble.notify({ title="ГРОМКОСТЬ :" ..volume_level ,
                              text="BASS      :" ..bass_level..  "TREBLE    :" ..treble_level,                                                           
                              position      =  "bottom_right",                                                                 
                              timeout = 10, 
                              width = 120                            
                              })end
   
    local function vol_update()
        volume_level = tonumber(awful.util.pread("/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1"))
        bass_level   = awful.util.pread("/usr/sbin/mixer bass|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1")
        treble_level   = awful.util.pread("/usr/sbin/mixer treble|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1")
        if volume_level == nil then
            connected = true         
            vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
        else
            connected = true                       
            if volume_level < 1 then
                vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
            elseif volume_level < 30 then
                vol_icon:set_image(ICON_DIR.."audio-output-none-panel.svg")
            elseif volume_level < 50 then
                vol_icon:set_image(ICON_DIR.."audio-volume-zero-panel.svg")
            elseif volume_level < 70 then
                vol_icon:set_image(ICON_DIR.."audio-volume-low-panel.svg")
            elseif volume_level < 90 then
                vol_icon:set_image(ICON_DIR.."audio-volume-medium-panel.svg")
            elseif volume_level < 100 then
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            else            
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            end
        end    
end

    vol_update()
    vol_timer:connect_signal("timeout", vol_update)
    vol_timer:start()

naughty_timer:connect_signal("timeout" ,notify_volume)

vol_icon:connect_signal("mouse::leave", function()naughty_timer:stop()end)       
vol_icon:connect_signal("mouse::leave", function()naughty.destroy(n)end)  
vol_icon:connect_signal("mouse::enter", function()notify_volume_d(d)end) 
vol_icon:connect_signal("mouse::leave", function()naughty.destroy(d)end)
 
    widgets_table["imagebox"]	= vol_icon  
    if widget then
	    widget:add(vol_icon)
    end   
vol_icon:buttons(
      keymap({ mouse.LEFT, function() vol_icon:mute() end },
             { mouse.WHEEL_UP, function() vol_icon:inc() end },
             { mouse.WHEEL_DOWN, function() vol_icon:dec() end },            
             { mouse.WHEEL_UP, function()naughty.destroy(d)end },
             { mouse.WHEEL_DOWN, function()naughty.destroy(d)end },
             { mouse.WHEEL_UP, function(_)naughty_timer:start(n)end},
             {mouse.WHEEL_DOWN, function(_)naughty_timer:start(n)end }))
    return widget
    
end

return setmetatable(mixer_vol, {__call = function(_,...) return worker(...) end})
