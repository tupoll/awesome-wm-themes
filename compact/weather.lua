local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")
local lain = require("lain")

local module = {}

myweather = lain.widgets.weather()


-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(myweather)       
    layout:add(myweather.icon)   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
