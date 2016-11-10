--[[
        File:      awful/screensaver/init.lua -- Awesome WM screensaver
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
    keygrabber = keygrabber
}

local module = {}

module.running = false
module.args = {}

local coords = 0
local count = 0
local area = nil

local function run()
    if not area then
        local has_visuals, visual = pcall(require, "awful.screensaver.mod."..module.args.mod)
        if has_visuals then
            area = wibox({ position = "free", screen = 1})
            area.ontop = true
            area:geometry({ width = (screen[1].geometry.width), height = screen[1].geometry.height, x = 0, y = 0})
            visual(module.args.mod_config,area)
        end
    end
    if area then area.visible = true end
    for _,r in ipairs(module.args.activate) do awful.util.spawn(r, false) end
    module.running = true
end
local function stop()
    if area and area.visible then area.visible = false end
    for _,r in ipairs(module.args.deactivate) do awful.util.spawn(r, false) end
    module.running = false
    module.count = 0
    count = 0
end

local stimer = capi.timer{ timeout = 1 }
stimer:connect_signal("timeout", function()
    local mc = capi.mouse.coords()
    local _coords = (mc.x + mc.y)

    if coords == _coords then
        if count == module.args.time then
            if not module.running then run() end
        else
            count = count + 1
        end
    else
        if module.running then stop() end
        count = 0
        coords = _coords
    end
end)

-- I have no idea how to reset counter when key pressed :-/
key.connect_signal("press", function()
    if module.running then stop() end
end)

-- when a client gains focus
client.connect_signal("focus", function()
    if module.running then stop() end
end)

local function new(args)
    local args = args or {}
    module.args.mod = args.mod or "version"
    module.args.mod_config  = args.mod_config or {}
    module.args.activate = args.activate or {}
    module.args.deactivate = args.deactivate or {}
    module.args.time = args.time or 3600

    if os.getenv("USER") == "minde" then -- experiment.
        stimer:start()
        --module.args.time = 10
    end
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })