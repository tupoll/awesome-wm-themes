local wibox     = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local naughty       = require('naughty')
local beautiful = require("beautiful")
local common    = require("compact.common.helpers1")
local timer    = require("gears.timer")
local vol       =require("compact.sox.vol")
local HOME = os.getenv("HOME")

local sox = {}
local function worker(args)
    local args = args or {}
    
    local res         = ".config/awesome/themes/pattern_freebsd/play/"
    local interface     = args.interface or "play"
    local timeout       = args.timeout or 5     
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
 
local function playlist() awful.spawn.easy_async_with_shell(".config/awesome/compact/sox/list.lua") end 
local function stop() os.execute("pkill -f play") end
local function forward() os.execute("killall sox") end
local function revers() awful.spawn.easy_async_with_shell(".config/awesome/compact/sox/drivers/play1.sh") end
local function start() awful.spawn.easy_async_with_shell(".config/awesome/compact/sox/drivers/play.sh") end
local function myplaylist() awful.spawn.easy_async_with_shell(".config/awesome/compact/sox/playlist.lua") end 

      local play = awful.widget.button({ image = res .. "play.png" })
      local pl = awful.widget.button({ image = res .. "playlist.png" })
      local st = awful.widget.button({ image = res .. "stop.png" })
      local ff = awful.widget.button({ image = res .. "next.png" })
      local rv = awful.widget.button({ image = res .. "repeat.png" })
      local mypl = awful.widget.button({ image = res .. "ape.png" })
      local soxvol = awful.widget.button({ image = res .. "sox-vol.png"})
      widget:add(pl, mypl, rv, play, st, ff, soxvol) 
              
        local notification
function playlist_status()
    awful.spawn.easy_async([[zsh -c '~/.config/awesome/compact/sox/playlist_status.lua']],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text =  stdout,
                title = "Проигранное:",
                position      =  "bottom_left",
                timeout = 100, hover_timeout = 0.5,
                width = 530,
                preset  = notification_preset
            }
        end
    )
end
local naughty_timer = timer({ timeout = 10})
naughty_timer:connect_signal("timeout" ,playlist_status)

widget:connect_signal("mouse::enter", function() playlist_status() end)
widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end) 
widget:connect_signal("mouse::enter", function()naughty_timer:start(notification) end)
widget:connect_signal("mouse::leave", function()naughty_timer:stop(notification) end)
     
      pl:buttons(
      keymap({ mouse.LEFT, function()  playlist() end  }))
           
      play:buttons(
      keymap({ mouse.LEFT, function() start() end },
      { mouse.LEFT, function()naughty.destroy(n)end }))
      
      st:buttons(
      keymap({ mouse.LEFT, function() stop() end },
      { mouse.LEFT, function()naughty.destroy(n)end }))
      
      ff:buttons(
      keymap({ mouse.LEFT, function() forward() end },
      { mouse.LEFT, function()naughty.destroy(n)end }))
      
      rv:buttons(
      keymap({ mouse.LEFT, function()  revers() end  },     
      { mouse.LEFT, function()naughty.destroy(n)end }))
      
      mypl:buttons(
      keymap({ mouse.LEFT, function()  myplaylist() end  },     
      { mouse.LEFT, function()naughty.destroy(n)end }))
      
      soxvol:buttons(
      keymap({ mouse.LEFT, function() vol.main()  end  }))     
      
           
    return widget
  end  
      
return setmetatable(sox, {__call = function(_,...) return worker(...) end})
