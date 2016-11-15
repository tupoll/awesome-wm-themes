local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local exit    = require("compact.exit")
local skb    = require("compact.skb_exit.skb")

local module = {}


-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()   
    layout:add(skb())
    layout:add(exit())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
