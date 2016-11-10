local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local exit    = require("unity.exit")
local skb    = require("unity.skb_exit.skb")

local module = {}


-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()
    layout:add(exit())
    layout:add(skb())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
