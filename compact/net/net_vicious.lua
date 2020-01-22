local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local vicious = require("vicious")

local module = {}

netdowninfo = wibox.widget.textbox(text)
    netdowninfo:set_align("center")
    netdowninfo:set_valign("center")
    netdowninfo.fit = function() return 40,30 end    
vicious.register(netdowninfo, vicious.widgets.net,"${eth0 down_kb}", 1 )
local netupinfo = wibox.widget.textbox()
    netupinfo:set_align("center")
    netupinfo:set_valign("center")
    netupinfo.fit = function() return 40,30 end 
vicious.register(netupinfo, vicious.widgets.net,"${eth0 up_kb}", 2 )

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
	local widget = wibox.container.background(netupinfo, beautiful.widget["bg"])   
    local widget1 = wibox.container.background(netdowninfo, beautiful.widget["bg"])
    local layout = wibox.layout.fixed.horizontal()
    local widget_txt1,text = common.textbox({ text="UP", width=30 })    
    local widget_txt2,text = common.textbox({ text="  DOWN", width=50 })                     
    layout:add(widget_txt1 ,widget, widget_txt2, widget1)   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
