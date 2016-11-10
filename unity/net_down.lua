local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local vicious = require("extern.vicious")
--local netd_icon = require("unity.net_down.netd_icon")

local module = {}

netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net,"${eth1 down_kb}" ,1 )

-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()
   -- layout:add(netd_icon())
   -- layout:add(common.textbox({text="Rx", width=30 }))
    layout:add(common.imagebox({icon=beautiful.rx_icon}))
    layout:add(netdowninfo)   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
