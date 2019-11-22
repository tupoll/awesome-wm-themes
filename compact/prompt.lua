local awful     = require("awful")
local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local wibox     = require("awful.wibox")

local module = {}


module.prompt = awful.widget.prompt()


    

-- Command prompt

function module.run()
    awful.prompt.run({
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        prompt = beautiful.prompt["cmd"],
        textbox = module.prompt.widget,
        completion_callback = module.prompt.completion_callback,
        history_path = gfs.get_cache_dir() .. '/history',
       exe_callback = function(...) awful.spawn.easy_async_with_shell(...) end
    },
        module.prompt.textbox)    
end

-- Run in terminal
function module.cmd()
    awful.prompt.run{
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        prompt = beautiful.prompt["run"],
        textbox = module.prompt.widget,
        completion_callback = module.prompt.completion.shell,
        history_path = gfs.get_cache_dir() .. '/history',
         module.prompt.widget,
        exe_callback = function(...) awful.spawn.easy_async_with_shell("urxvt-aw ".. ...) end 
    }
end

-- Lua prompt
function module.lua()
    awful.prompt.run{
        fg_cursor = beautiful.prompt["fg_cursor"],
        bg_cursor = beautiful.prompt["bg_cursor"],
        ul_cursor = beautiful.prompt["ul_cursor"],
        font = beautiful.prompt["font"],
        textbox = module.prompt.widget,
        prompt = beautiful.prompt["lua"],
        history_path = gfs.get_cache_dir() .. '/history',
        module.prompt.widget,
        awful.util.eval,
        nil
    }
end

local function new()
    return module.prompt
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
