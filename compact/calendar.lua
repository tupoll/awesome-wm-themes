local orglendar = require('compact.orglendar')
local awful     = require("awful")
local wibox     = require("wibox")
local common    = require("compact.common.helpers1")
local beautiful = require("beautiful")


local module = {}

local function new()
    local mytextclock = wibox.widget.textclock("%A %d %B")
    mytextclock:set_align("center")
    mytextclock:set_valign("center")
    mytextclock.fit = function() return 160,30 end
    local widget = wibox.container.background(mytextclock, beautiful.widget["bg"])
    orglendar.register(mytextclock)
    local layout = wibox.layout.fixed.horizontal() 
    local widget_txt,text = common.textbox({text=" ", width=40 })  
    layout:add(widget ,widget_txt)    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })