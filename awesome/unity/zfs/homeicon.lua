local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")
local home = {}
local function worker(args)
    local args = args or {}

    widgets_table = {}
    local connected = false

    -- Settings
    local ICON_DIR      = beautiful.path.."/icons/"
    local interface     = args.interface or "df"
    local timeout       = args.timeout or 1
    local font          = args.font or beautiful.font
    local popup_signal  = args.popup_signal or false
    local onclick       = args.onclick
    local widget 	= args.widget == nil and wibox.layout.flex.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 6

    local home_icon = wibox.widget.imagebox()
    home_icon:set_image(ICON_DIR.."home1.png")   
    home_icon.fit = function() return 20,2 end 
    local home_timer = timer({ timeout = timeout })
    local signal_level = 0
    local function home_update()
        signal_level = tonumber(awful.util.pread("df /home|/usr/bin/awk '{print $5}"))
        if signal_level == nil then
            connected = true         
            home_icon:set_image(ICON_DIR.."home0.png")
        else
            connected = true                       
            if signal_level < 1 then
                home_icon:set_image(ICON_DIR.."home1.png")
            elseif signal_level < 30 then
                home_icon:set_image(ICON_DIR.."home2.png")
            elseif signal_level < 50 then
                home_icon:set_image(ICON_DIR.."home3.png")
            elseif signal_level < 70 then
                home_icon:set_image(ICON_DIR.."home4.png")
            elseif signal_level < 90 then
                home_icon:set_image(ICON_DIR.."home5.png")
            elseif signal_level < 100 then
                home_icon:set_image(ICON_DIR.."home6.png")
            else            
                home_icon:set_image(ICON_DIR.."home6.png")
            end
        end    
end

    home_update()
    home_timer:connect_signal("timeout", home_update)
    home_timer:start()
    home_icon:connect_signal(
    "mouse::enter", function()
       home = naughty.notify(
         {title="ЗАНЯТО НА RAID",text=awful.util.pread("df  /home|/usr/bin/awk  '{print $1,$5}' | sed '1d' | cut -c9-18 && df /|/usr/bin/awk '{print $6,$5}'| sed '1d' && echo СТАТУС && zpool status |/usr/bin/awk '{print $1,$2}'| sed '5,11d'") ,
        timeout = 0, hover_timeout = 0.5,
     position      =  "bottom_right",
     width = 150
  })  
end)
    home_icon:connect_signal(
   "mouse::leave", function()
      naughty.destroy(home)
end)  
    widgets_table["imagebox"]	= home_icon  
    if widget then
	    widget:add(home_icon)
    end   

      return widget
    
end

return setmetatable(home, {__call = function(_,...) return worker(...) end})
