--[[
        File:      awful/screensaver/mod/wallpaper.lua -- Wallpaper
        Date:      2014-01-31
      Author:      Mindaugas <mindeunix@gmail.com> http://minde.gnubox.com
   Copyright:      Copyright (C) 2013 Free Software Foundation, Inc.
     Licence:      GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
        NOTE:      -------
--]]

local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local capi = {
    mouse = mouse,
    screen = screen,
    timer = timer,
}

module = {}

local function new(conf,area)
    local layout = wibox.layout.align.vertical()
    local image = wibox.widget.imagebox()
    local bg = conf.image or beautiful.wallpaper
    image:set_image(bg)
    layout:set_middle(image)

    area:set_widget(layout)
end


return setmetatable(module, { __call = function(_, ...) return new(...) end })