
local wibox     = require("wibox")
local awful     = require("awful")
local memory  = require("compact.memory.memory_bsd")

local module = {}

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(memory())      
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })

