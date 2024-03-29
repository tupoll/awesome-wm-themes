local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")

local s    = require("compact.exit")
local c    = require("compact.clock")
local t    = require("compact.tasklist")
local w    = require("compact.weather")
local n    = require("compact.net.net_vicious")
local d    = require("compact.calendar")
local m    = require("compact.mixer")
local r    = require("compact.memory.memory_bsd")
local i    = require("compact.cpu")
local z    = require("compact.mount.zfs")
local y    = require("compact.prompt")
local f    = require("wibox.widget.systray")
local e    = require("awful.widget.keyboardlayout")


local function new()
    local layout = wibox.layout.flex.horizontal()
    local middle_layout = wibox.layout.fixed.horizontal()
     
    middle_layout:add(z())
    middle_layout:add(r())
    middle_layout:add(i())        
    middle_layout:add(w())
    middle_layout:add(m())
  --  middle_layout:add(n())
    middle_layout:add(c())
    local right_layout = wibox.layout.flex.vertical()    
    local top_layout = wibox.layout.fixed.horizontal()    
    top_layout:add(f())
    top_layout:add(y())
    top_layout:add(t())
        
    right_layout:add(top_layout)
    local bottom_layout = wibox.layout.fixed.horizontal()
    bottom_layout:add(d())
    bottom_layout:add(n())    
    bottom_layout:add(e())
    bottom_layout:add(s()) 
      
    right_layout:add(bottom_layout)
    layout:add(middle_layout)
    layout:add(right_layout)
    return layout
end

return (function(_, ...) return new(...) end )
