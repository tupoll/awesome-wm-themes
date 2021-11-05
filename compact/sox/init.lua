local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local playbar       = require("compact.sox.playbar")

local module = {}

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
        layout:add(playbar())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
