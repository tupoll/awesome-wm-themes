local wibox     = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local homeicon    = require("compact.zfs.homeicon")
local home    = require("compact.zfs.home")

local module = {}


local function new()
    local layout = wibox.layout.fixed.horizontal()    
    layout:add(homeicon())
    layout:add(home())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })


