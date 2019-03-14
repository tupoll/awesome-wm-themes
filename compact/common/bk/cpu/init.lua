local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local cpuicon   = require("compact.cpu.cpuicon")
local cpu       = require("compact.cpu.cpu")

local module = {}

-- CPU

cpuwidget = wibox.container.background(cpu({
settings = function()
widget:set_text("" .. cpu_now.usage .. "% ")
end
}), "#31313100")


-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(common.textbox({text="", width=5 }))
    layout:add(cpuicon())      
    layout:add(cpuwidget) 
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
