local awful     = require("awful")
local wibox     = require("wibox")
local common    = require("compact.common")
local beautiful = require("beautiful")


local module = {}

local function new()
    local clock = awful.widget.textclock("<span font='snap 12' color='"..beautiful.widget["fg"].."'>%H %M</span> ", 30)
    clock:set_align("center")
    clock:set_valign("center")
    clock.fit = function() return 62,10 end
    local widget = wibox.widget.background(clock, beautiful.widget["bg"])
    local layout = wibox.layout.fixed.horizontal()
    layout:add(widget)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
