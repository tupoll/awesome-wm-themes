local awful     = require("awful")
local wibox     = require("wibox")
local common    = require("unity.common")
local beautiful = require("beautiful")


local module = {}

local function new()
    local clock = awful.widget.textclock("<span font='snap 11' color='"..beautiful.widget["fg"].."'>%H %M</span> ", 60)
    clock:set_align("center")
    clock:set_valign("center")
    clock.fit = function() return 62,10 end
    local widget = wibox.widget.background(clock, beautiful.widget["bg"])
    local layout = wibox.layout.flex.horizontal()
   -- layout:add(common.arrow(3))
    layout:add(widget)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
