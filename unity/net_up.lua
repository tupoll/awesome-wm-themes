local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local vicious = require("extern.vicious")
--local netup_icon = require("unity.net_up.netup_icon")

local module = {}

netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net,"${eth1 up_kb}" ,2 )

-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()    
   -- layout:add(common.textbox({text="Tx", width=30 }))
   -- layout:add(netup_icon())
    layout:add(common.imagebox({icon=beautiful.tx_icon}))   
    layout:add(netupinfo)
    return layout
end


return setmetatable(module, { __call = function(_, ...) return new(...) end })

