local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local common    = require("compact.common")
local l    = require("compact.layout")
local m    = require("compact.menu")
local t    = require("wibox.widget.systray")
local p       = require("compact.prompt")



local function new()
    local layout = wibox.layout.flex.vertical()
    local top_layout = wibox.layout.fixed.horizontal()
    top_layout:add(l())   
    top_layout:add(m())
    
    local bottom_layout = wibox.layout.fixed.horizontal()    
    bottom_layout:add(p())    
    bottom_layout:add(t())

    layout:add(top_layout)
    layout:add(bottom_layout)
    return layout
end

return (function(_, ...) return new(...) end )
