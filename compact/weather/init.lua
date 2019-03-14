local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local weather1   = require("compact.weather.weather1")

local module = {}

myweather = weather1()


-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(myweather.icon)
    layout:add(myweather)       
       
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
