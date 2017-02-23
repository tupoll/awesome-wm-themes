local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")
local vicious = require("extern.vicious")

local module = {}

netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net,"${eth0 down_kb}", 1 )
netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net,"${eth0 up_kb}", 2 )

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(common.textbox({ text=" ", width=40 }))     
    layout:add(common.imagebox({ icon=beautiful.path.."/widgets/up.png" }))
    layout:add(netupinfo)
    layout:add(common.imagebox({ icon=beautiful.path.."/widgets/kbs.png" }))
    layout:add(common.imagebox({ icon=beautiful.path.."/widgets/down.png" }))
    layout:add(netdowninfo)
    layout:add(common.imagebox({ icon=beautiful.path.."/widgets/kbs.png" }))
    layout:add(common.textbox({ text=" ", width=40 }))
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
