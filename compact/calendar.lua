local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local orglendar = require('compact.orglendar')

local module = {}

os.setlocale(os.getenv("LANG"))
mytextclock = wibox.widget.textclock(" %A %d %B ")
orglendar.register(mytextclock)

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()    
    layout:add(mytextclock)    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
