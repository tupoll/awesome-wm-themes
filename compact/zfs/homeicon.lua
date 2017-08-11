local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")
local home = {}
local function worker(args)
    local args = args or {}

    -- Settings
    local ICON_DIR      = beautiful.path.."/icons/"
    local df            = args.df or "df"
    local timeout       = args.timeout or 1    
    local widget 	= args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 6

    local home_icon = wibox.widget.imagebox()
    home_icon:set_image(ICON_DIR.."home1.png")   
    home_icon.fit = function() return 32,20 end 
    local home_timer = timer({ timeout = timeout })
   
    local function home_update()
        local cmd = { "zsh", "-c", "df /home/tupoll|/usr/bin/awk '{print $5}' | sed '1d'| cut -c1-2"}   --"df /home/tupoll|/usr/bin/awk '{print $5}' | sed '1d'| cut -c1-2"}
        awful.spawn.easy_async(cmd, function(stdout, _, _, _, stderr, reason, exit_code)
         cmd = tonumber(string.format("% 3d", stdout))
                
        if cmd == nil then         
            home_icon:set_image(ICON_DIR.."home0.png")
        else                                   
            if cmd < 5 then
                home_icon:set_image(ICON_DIR.."home1.png")
            elseif cmd < 30 then
                home_icon:set_image(ICON_DIR.."home2.png")
            elseif cmd < 50 then
                home_icon:set_image(ICON_DIR.."home3.png")
            elseif cmd < 70 then
                home_icon:set_image(ICON_DIR.."home4.png")
            elseif cmd < 90 then
                home_icon:set_image(ICON_DIR.."home5.png")
            elseif cmd < 100 then
                home_icon:set_image(ICON_DIR.."home6.png")
            else            
                home_icon:set_image(ICON_DIR.."home6.png")
            end
        end        
 end)          
end
 
    home_update()
    home_timer:connect_signal("timeout", home_update)
    home_timer:start()
     
      local notification
      function zpool_status()
      awful.spawn.easy_async([[zsh -c "df  /home/tupoll|/usr/bin/awk  '{print $1,$5}' | sed '1d' | cut -c9-24 && df /|/usr/bin/awk '{print $6,$5}'| sed '1d' && echo СТАТУС && zpool status |/usr/bin/awk '{print $1,$2}'| sed '5,11d'"]],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text =  stdout,
                title = "ЗАНЯТО НА RAID",
                position      =  "bottom_left",
                timeout = 0, hover_timeout = 0.5,
                width = 180,
            }
        end    
    )
end  
        
    home_icon:connect_signal("mouse::enter", function() zpool_status() end)
    home_icon:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
           
	    widget:add(home_icon)
       
      return widget
    
end

return setmetatable(home, {__call = function(_,...) return worker(...) end})
