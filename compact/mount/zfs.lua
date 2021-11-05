local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local vicious = require("vicious")
local blingbling = require("blingbling")
local naughty       = require('naughty')

local module = {}

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

home_fs_usage=blingbling.value_text_box({height = 14, width = 60, v_margin = 3})
	home_fs_usage:set_text_background_color(beautiful.widget_background)
	home_fs_usage:set_values_text_color("#A807A8")
	home_fs_usage:set_text_color("#508191")	
	home_fs_usage:set_font_size(10)
	home_fs_usage:set_background_color("#00000000")
	home_fs_usage:set_label("home: $percent %")

	vicious.register(home_fs_usage, vicious.widgets.fs, "${/home/tupoll used_p}", 120 )
	
	root_fs_usage=blingbling.value_text_box({height = 14, width = 60, v_margin = 3})
	root_fs_usage:set_text_background_color(beautiful.widget_background)
	root_fs_usage:set_values_text_color(colors_stops)	
	root_fs_usage:set_font_size(10)
	root_fs_usage:set_text_color("#508191")
	root_fs_usage:set_background_color("#00000000")
	root_fs_usage:set_label("root: $percent %")

	vicious.register(root_fs_usage, vicious.widgets.fs, "${/ used_p}", 120 )
 
 local notification
      function zfs_status()
      awful.spawn.easy_async([[zsh -c "df -h  /home/$USER|/usr/bin/awk  '{print $1,$5}' | sed '1d' | cut -c6-24 && df /|/usr/bin/awk '{print $6,$5}'| sed '1d' && echo СТАТУС && zpool status |/usr/bin/awk '{print $1,$2}'| sed '5,11d'"]],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text =  stdout,
                title = "ZPOOL STATUS",
                position      =  "bottom_left",
                timeout = 100, hover_timeout = 0.5,
                width = 180,
            }
        end    
    )
end  
        
--    home_fs_usage:connect_signal("mouse::enter", function() zfs_status() end)
--    home_fs_usage:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
    
    home_fs_usage:buttons(
      keymap({ mouse.LEFT,function() zfs_status() end},
      { mouse.LEFT, function()naughty.destroy(n)end })) 
 
-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.vertical()      
    layout:add(home_fs_usage, root_fs_usage)
     
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
