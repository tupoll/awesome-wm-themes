local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")
local spawn         = require("awful.spawn")
local mixer_vol = {}
local function worker(args)
    local args = args or {}
   
    -- Settings
    local ICON_DIR      = beautiful.path.."/mixer/"
    local interface     = args.interface or "mixer vol"
    local timeout       = args.timeout or 1   
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

function mixer_vol.inc(stdout)
    awful.spawn("mixer vol +5") 
end

function mixer_vol.dec()
    awful.spawn("mixer vol -5")
end

function mixer_vol.mute(w)
    awful.spawn("mixer vol 0")
end

    local vol_icon = wibox.widget.imagebox()
    vol_icon.inc = mixer_vol.inc
    vol_icon.dec = mixer_vol.dec
    vol_icon.mute = mixer_vol.mute
    local vol_timer = timer({ timeout = timeout })
    
    --local volume_level = stdout
    local bass_level   = 0
    local treble_level = 0
    
    local notification
    function mixer_status()
    awful.spawn.easy_async([[zsh -c '~/.config/awesome/compact/mixer/mixer.sh']],
        function(stdout, _, _, _)
            notification = naughty.notify{
                title = "MIXER",
                text = stdout,               
                position      =  "bottom_right",
                timeout = 1, hover_timeout = 0.5,
                width = 120,
                preset  = notification_preset
            }
        end
    )
end
local naughty_timer = timer({ timeout = 1})
naughty_timer:connect_signal("timeout", mixer_status)     
   
     local function vol_update()
       
        local cmd = { "zsh", "-c", "~/.config/awesome/compact/mixer/vol.sh"}   
        awful.spawn.easy_async(cmd, function(stdout, _, _, _, stderr, reason, exit_code)
         cmd = tonumber(string.format("% 3d", stdout))

        if cmd == nil then                   
            vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
        else                      
             if cmd < 1 then
                vol_icon:set_image(ICON_DIR.."audio-volume-muted-panel.svg")
            elseif cmd < 30 then
                vol_icon:set_image(ICON_DIR.."audio-output-none-panel.svg")
            elseif cmd < 50 then
                vol_icon:set_image(ICON_DIR.."audio-volume-zero-panel.svg")
            elseif cmd < 70 then
                vol_icon:set_image(ICON_DIR.."audio-volume-low-panel.svg")
            elseif cmd < 90 then
                vol_icon:set_image(ICON_DIR.."audio-volume-medium-panel.svg")
            elseif cmd < 100 then
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            else            
                vol_icon:set_image(ICON_DIR.."audio-volume-high-panel.svg")
            end
        end
     end)       
end

    vol_update()
    vol_timer:connect_signal("timeout", vol_update)
    vol_timer:start()       

vol_icon:connect_signal("mouse::leave", function()naughty_timer:stop()end)       
vol_icon:connect_signal("mouse::leave", function()naughty.destroy(n)end)  
 
vol_icon:connect_signal("mouse::enter", function()naughty_timer:start(notification) end)
vol_icon:connect_signal("mouse::leave", function()naughty_timer:stop(notification) end)
     
	    widget:add(vol_icon)
      
vol_icon:buttons(
      keymap({ mouse.LEFT, function() vol_icon:mute() end },
             { mouse.WHEEL_UP, function() vol_icon:inc() end },
             { mouse.WHEEL_DOWN, function() vol_icon:dec() end },            
             { mouse.WHEEL_UP, function()naughty.destroy()end },
             { mouse.WHEEL_DOWN, function()naughty.destroy()end },
             { mouse.WHEEL_UP, function(_)naughty_timer:start()end},
             {mouse.WHEEL_DOWN, function(_)naughty_timer:start()end }))
             
    return widget    
end

return setmetatable(mixer_vol, {__call = function(_,...) return worker(...) end})
