--[[
        File:      awful/dbg/init.lua
        Date:      2013-10-28
      Author:      Mindaugas <mindeunix@gmail.com> http://minde.gnubox.com
   Copyright:      Copyright (C) 2013 Free Software Foundation, Inc.
     Licence:      GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
        NOTE:      -------
--]]

local naughty = require("naughty")
local dumper  = require("awful.dbg.dumper")

local module = {}

module.preset = {
    error = {
        timeout = 0,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#EC7F6B",
        border_color = "#E15500",
        border_width = 1,
        hover_timeout = nil
    },
    info = {
        timeout = 5,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#6DB1E6",
        border_color = "#1D405A",
        border_width = 1,
        hover_timeout = nil
    },
    dump = {
        timeout = 0,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#F7DD65",
        border_color = "#FFB111",
        border_width = 1,
        hover_timeout = nil
    },
    deprecation = {
        title = "debug::deprecation",
        timeout = 0,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#F7DD65",
        border_color = "#E15500",
        border_width = 1,
        hover_timeout = nil
    },
    index_miss = {
        title = "An invalid key was read from an object!",
        timeout = 0,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#F7DD65",
        border_color = "#E15500",
        border_width = 1,
        hover_timeout = nil
    },
    newindex_miss = {
        title = "An invalid key was written to an object!",
        timeout = 0,
        position = "bottom_right",
        margin = 1,
        gap = 10,
        ontop = true,
        font = "monospace 8",
        fg = "#000000",
        bg = "#F7DD65",
        border_color = "#E15500",
        border_width = 1,
        hover_timeout = nil
    }
}
module.in_error = false
module.loaded = false

local function dump(data)
    -- There are eight basic types in Lua: nil, boolean, number, string, userdata, function, thread, and table
    local color = {}
    color["nil"]="#ff0800"
    color["boolean"]="#fe00ff"
    color["number"]="#00d6ff"
    color["string"]="#40a02f"
    color["userdata"]="#452fa0"
    color["function"]="#99007E"
    color["thread"]="#a02f5f"
    color["table"]="#0049BA"
    
    return "<b><span color='"..color[type(data)].."'>"..type(data).."</span></b>: "..dumper(data)
end

--- Dump the table (or any other value).
-- @param m text
function module.dump(object)
    naughty.notify({
        text = dump(object),
        preset = module.preset["dump"]
    })
end
--- Error
-- @param msg text
function module.error(msg)
    local text
    if not msg then text = "A call into the lua code aborted with an error"
    else text = msg end
    naughty.notify({
        text = debug.traceback(text, 2),
        preset = module.preset["error"]
    })
end
--- Info
-- @param msg text
function module.info(msg)
    naughty.notify({
        text = msg,
        preset = module.preset["info"]
    })
end


-- A call into the lua code aborted with an error
awesome.connect_signal("debug::error", function(e)
    -- Make sure we don't go into an endless error loop.
    if module.in_error then return end
    module.in_error = true
    naughty.notify({
        preset = module.preset["error"],
        title = "debug::error",
        text = debug.traceback(e, 2),
    })
    module.in_error = false
end)
-- A deprecated lua function was called.
awesome.connect_signal("debug::deprecation", function(e)
    naughty.notify({ preset = module.preset["deprecation"], text = e })
end)
-- An invalid key was read from an object (e.g. c.foo)
awesome.connect_signal("debug::index::miss", function(object, key)
    naughty.notify({
        preset = module.preset["index_miss"],
        text = debug.traceback("Object:\t"..tostring(object).."\nKey:\t\t"..tostring(key), 2)
    })
end)
-- Executed then an invalid key was written to an object (e.g. c.foo = "bar")
awesome.connect_signal("debug::newindex::miss", function(object, key, value)
    naughty.notify({
        preset = module.preset["newindex_miss"],
        text = debug.traceback("Object:\t"..tostring(object).."\nKey:\t\t"..tostring(key).."\nValue:\t"..tostring(value), 2)
    })
end)
-- Startup error
if awesome.startup_errors then
    -- Check if awesome encountered an error during startup and fell back to
    -- another config (This code will only ever execute for the fallback config).
    naughty.notify({
        preset = module.preset["error"],
        title = "STARTUP ERROR",
        text = awesome.startup_errors
    })
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })