
local wibox     = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local timer    = require("gears.timer")

local module = {}

os_widget = wibox.widget.textbox(w)

local function w_update()
local cmd = {"zsh", "-c", "uname -s"}
awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
  os_widget:set_markup(stdout) 
end)
end
      w_update()
      local w_timer = timer({ timeout = 15 ,hover_timeout = 0.5})
      w_timer:connect_signal("timeout", w_update)
      w_timer:start()
  
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget_txt,text = common.textbox({text="  OS-", width=30 })    
    layout:add(widget_txt, os_widget)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
               