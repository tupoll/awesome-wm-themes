--[[
        File:      awful/screensaver/mod/clock.lua -- Shows time.
        Date:      2014-01-31
      Author:      Mindaugas <mindeunix@gmail.com> http://minde.gnubox.com
   Copyright:      Copyright (C) 2013 Free Software Foundation, Inc.
     Licence:      GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
        NOTE:      -------
--]]
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local capi = {
    mouse = mouse,
    screen = screen,
    timer = gears.timer,
}

module = {}
module.text=nil
module.area=nil
module.format=nil

local stimer = capi.timer{ timeout = 1 }
stimer:connect_signal("timeout", function()
    module.text:set_markup(os.date(module.format))
    if not module.area.visible then stimer:stop() end
end)

local function new(conf,area)
    local layout = wibox.layout.align.vertical()
    module.text = wibox.widget.textbox()
    module.format = conf.format or "%H %M %S"
    module.area = area
    local font = conf.font or "Crashed Scoreboard 200"

    module.text:set_align("center")
    module.text:set_valign("center")
    module.text:set_font(font)
    layout:set_middle(module.text)

    module.area:set_widget(layout)
    stimer:start()
end


return setmetatable(module, { __call = function(_, ...) return new(...) end })
