local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local vicious = require("vicious")
local blingbling = require("blingbling")


local module = {}

netwidget = blingbling.net({interface = "eth0", show_text = true,
                                                text_background_color = "#00000000",
                                                text_color = "#7F7F7F",
                                                font = 'Terminus Bold' })


local function new()
	local layout = wibox.layout.flex.vertical()    
    layout:add(netwidget)    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
