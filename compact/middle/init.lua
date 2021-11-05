local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local u    = require("compact.unitybar")
local p    = require("compact.places")

local function new()
    local layout = wibox.layout.fixed.horizontal()
    local right_layout = wibox.layout.fixed.horizontal()
    local left_layout = wibox.layout.flex.vertical()
   
    right_layout:add(u())
          
    local top_layout = wibox.layout.fixed.horizontal()    
    top_layout:add(p())
            
    left_layout:add(top_layout)
    local bottom_layout = wibox.layout.fixed.horizontal()
    
        
    left_layout:add(bottom_layout)
    layout:add(left_layout)
    layout:add(right_layout)
    return layout
end

return (function(_, ...) return new(...) end )
