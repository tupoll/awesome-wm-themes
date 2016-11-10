local wibox     = require("wibox")
--local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local homeicon    = require("unity.zfs.homeicon")
local home    = require("unity.zfs.home")

local module = {}


local function new()
    local layout = wibox.layout.flex.horizontal()    
    layout:add(homeicon())
    layout:add(home())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })


