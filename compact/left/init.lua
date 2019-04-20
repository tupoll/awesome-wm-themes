local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local m    = require("compact.menu")



local function new()
    
    local layout = wibox.layout.fixed.horizontal() 
    layout:add(m())
    return layout
end

return (function(_, ...) return new(...) end )
