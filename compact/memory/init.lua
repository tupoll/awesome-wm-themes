local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local vicious = require("vicious")
local blingbling = require("blingbling")
local naughty       = require('naughty')

local module = {}

mem_graph = blingbling.line_graph({ height = 29,
                                      width = 60,
                                      show_text = true,
                                      text_color = "#E5E5E5",
                                      graph_line_color = "#0C5A0C",
                                      graph_color = "#0C5A0C",
                                      label = "MEM: $percent %",
                                     })
mem_graph.fit = function() return 60,5 end
	vicious.register(mem_graph, vicious.widgets.mem, '$1', 2)

local notification
function memory_status()
    awful.spawn.easy_async([[bash -c '~/.config/awesome/compact/memory/memory.sh']],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text =  stdout,
                title = "MEMORY STATUS",
                position      =  "bottom_left",
                timeout = 80, hover_timeout = 0.5,
                width = 680,
            }
        end
    )
end
mem_graph:connect_signal("mouse::enter", function() memory_status() end)
mem_graph:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()

    layout:add(mem_graph)
     
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
