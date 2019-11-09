local awful     = require("awful")
local beautiful = require("beautiful")

local module = {}
local args ={}

module.prompt = awful.widget.prompt()


    keypressed_callback = keypressed_callback or args.keypressed_callback
    changed_callback    = changed_callback    or args.changed_callback
    done_callback       = done_callback       or args.done_callback
    history_max         = history_max         or args.history_max
    history_path        = history_path        or args.history_path
    completion_callback = completion_callback or args.completion_callback
    exe_callback        = exe_callback        or args.exe_callback
    textbox             = textbox             or args.textbox


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
        function(...) awful.spawn.easy_async_with_shell(...) end,
        --awful.completion.shell,
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
        function(...) awful.spawn.easy_async_with_shell("urxvt-aw ".. ...) end,
        --awful.completion.shell,
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
