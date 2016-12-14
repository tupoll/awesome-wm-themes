local awful     = require("awful")
local beautiful = require("beautiful")

local module = {}

module.prompt = awful.widget.prompt()

-- Command prompt
function module.run()
    awful.prompt.run({
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        prompt = beautiful.prompt["cmd"]
    },
        module.prompt.widget,
        function(...) awful.util.spawn(...) end,
        awful.completion.shell,
        awful.util.getdir("cache").. "/history_run", 50
    )
end

-- Run in terminal
function module.cmd()
    awful.prompt.run({
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        prompt = beautiful.prompt["run"]
    },
        module.prompt.widget,
        function(...) awful.util.spawn("urxvt-aw ".. ...) end,
        awful.completion.shell,
        awful.util.getdir("cache").. "/history_cmd", 50
    )
end

-- Lua prompt
function module.lua()
    awful.prompt.run({
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        prompt = beautiful.prompt["lua"]
    },
        module.prompt.widget,
        awful.util.eval,
        nil,
        awful.util.getdir("cache").. "/history_eval", 50
    )
end

local function new()
    return module.prompt
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })