local wibox     = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local homeicon    = require("compact.zfs.homeicon")
local common    = require("compact.common")

local module = {}

fswidget = wibox.widget.textbox(w)

local function w_update()
local cmd = {"zsh", "-c", "df /home/tupoll|/usr/bin/awk '{print $5}' | sed '1d'"}
awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
  fswidget:set_markup(stdout) 
end)
end
      w_update()
      local w_timer = timer({ timeout = 10 ,hover_timeout = 0.5})
      w_timer:connect_signal("timeout", w_update)
      w_timer:start()
  
local function new()
    local layout = wibox.layout.fixed.horizontal()    
    layout:add(homeicon(), fswidget)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })


