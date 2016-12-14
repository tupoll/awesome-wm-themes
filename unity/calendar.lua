local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")
local orglendar = require('unity.orglendar')

local module = {}

mytextclock = awful.widget.textclock(" %a %d ")
orglendar.register(mytextclock)

-- Return widgets layout
local function new()
    local layout = wibox.layout.flex.horizontal()
      
    layout:add(mytextclock)    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
