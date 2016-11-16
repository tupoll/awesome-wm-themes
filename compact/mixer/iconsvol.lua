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
    local popup_signal  = args.popup_signal or false
    local onclick       = args.onclick
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
    local signal_level = 0
    local function vol_update()
        signal_level = tonumber(awful.util.pread("/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1"))
        if signal_level == nil then
            connected = true         
            vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
        else
            connected = true                       
            if signal_level < 1 then
                vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
            elseif signal_level < 30 then
                vol_icon:set_image(ICON_DIR.."audio-output-none-panel.svg")
            elseif signal_level < 50 then
                vol_icon:set_image(ICON_DIR.."audio-volume-zero-panel.svg")
            elseif signal_level < 70 then
                vol_icon:set_image(ICON_DIR.."audio-volume-low-panel.svg")
            elseif signal_level < 90 then
                vol_icon:set_image(ICON_DIR.."audio-volume-medium-panel.svg")
            elseif signal_level < 100 then
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            else            
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            end
        end    
end

    vol_update()
    vol_timer:connect_signal("timeout", vol_update)
    vol_timer:start()
 
  vol_icon:connect_signal(
   "mouse::enter", function()
       volume = naughty.notify(
         {title="ГРОМКОСТЬ",text=awful.util.pread("/usr/sbin/mixer vol|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1&& /usr/sbin/mixer bass|/usr/bin/awk '{print $2}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer bass|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer treble|/usr/bin/awk '{print $2}'|/usr/bin/cut -d: -f1 && /usr/sbin/mixer treble|/usr/bin/awk '{print $7}'|/usr/bin/cut -d: -f1") ,
          position      =  "bottom_right",
         -- timeout = 1, hover_timeout = 0.5,
          width = 80
  })  
end)
vol_icon:connect_signal(
   "mouse::leave", function()
      naughty.destroy(volume)
end)  

    widgets_table["imagebox"]	= vol_icon  
    if widget then
	    widget:add(vol_icon)
    end   
vol_icon:buttons(
      keymap({ mouse.LEFT, function() vol_icon:mute() end },
             { mouse.WHEEL_UP, function() vol_icon:inc() end },
             { mouse.WHEEL_DOWN, function() vol_icon:dec() end }))
      return widget
    
end

return setmetatable(mixer_vol, {__call = function(_,...) return worker(...) end})
