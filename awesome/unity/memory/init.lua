local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local vicious = require("extern.vicious")
local memicon    = require("unity.memory.memicon")

local module = {}

 memwidget = wibox.widget.textbox()

	vicious.register(memwidget, vicious.widgets.mem, '$1%', 1) --2-mb

-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()
    layout:add(memicon())      
    layout:add(memwidget)
     
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
