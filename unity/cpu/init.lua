local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local cpuicon    = require("unity.cpu.cpuicon")
local lain = require("lain")


local module = {}

-- CPU

cpuwidget = wibox.widget.background(lain.widgets.cpu({
settings = function()
widget:set_text("" .. cpu_now.usage .. "% ")
end
}), "#31313100")


-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()
    layout:add(cpuicon())      
    layout:add(cpuwidget) 
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
