local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")
local vicious = require("extern.vicious")

local module = {}

netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net,"${eth1 down_kb}", 1 )
local netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net,"${eth1 up_kb}", 2 )

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget_txt1,text = common.textbox({ text=" ", width=30 })    
    local widget_img1,img = common.imagebox({ icon=beautiful.path.."/widgets/up.png" })         
    local widget_img2,img = common.imagebox({ icon=beautiful.path.."/widgets/kbs.png" })    
    local widget_img3,img = common.imagebox({ icon=beautiful.path.."/widgets/down.png" })    
    local widget_img4,img = common.imagebox({ icon=beautiful.path.."/widgets/kbs.png" })
    local widget_txt2,text = common.textbox({ text="", width=5})
    layout:add(widget_txt1 ,widget_img1, netupinfo, widget_img2, widget_txt2, widget_img3, netdowninfo, widget_img4, widget_txt1)   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
