local awful     = require("awful")
local wibox     = require("wibox")
local common    = require("compact.common.helpers1")
local beautiful = require("beautiful")


local module = {}

local function new()
    local clock = wibox.widget.textclock("<span font='LCDMono Bold 13' color='"..beautiful.widget["fg"].."'>%H %M</span> ", 30)
    clock:set_align("center")
    clock:set_valign("center")
    clock.fit = function() return 80,20 end
    local widget = wibox.container.background(clock, beautiful.widget["bg"])
    local layout = wibox.layout.fixed.horizontal()    
    layout:add(widget)    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
