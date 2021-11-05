local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local m    = require("compact.menu")
local l    = require("compact.layout")
local a       = require("compact.sox")

local function new()
    local layout = wibox.layout.fixed.horizontal()
    local left_layout = wibox.layout.fixed.horizontal()
        
    left_layout:add(m())
  
    local right_layout = wibox.layout.flex.vertical()    
    local top_layout = wibox.layout.fixed.horizontal()    
    top_layout:add(l())
        
    right_layout:add(top_layout)
    local bottom_layout = wibox.layout.fixed.horizontal()
    bottom_layout:add(a())
        
    right_layout:add(bottom_layout)
    layout:add(left_layout)
    layout:add(right_layout)
    return layout
end

return (function(_, ...) return new(...) end )
