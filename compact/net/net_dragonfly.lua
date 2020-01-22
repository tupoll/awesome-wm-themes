local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local timer     = require("gears.timer")

local module = {}

 netwidget = wibox.widget.textbox(w)     
local function w_update()
local cmd = {"zsh", "-c", "ifstat -n -i bge0 0.1 1 2>&1 | tail -n1"}
awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
  netwidget:set_markup(stdout) 
end)
end
      w_update()
      local w_timer = timer({ timeout = 5 ,hover_timeout = 0.5})
      w_timer:connect_signal("timeout", w_update)
      w_timer:start()
 
  
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget_txt1,text = common.textbox({ text="UP", width=20 })       
    local widget_txt2,text = common.textbox({ text="  DOWN  ", width=50})
    layout:add(widget_txt1, netwidget, widget_txt2)   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
