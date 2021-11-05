local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local vicious = require("vicious")
local blingbling = require("blingbling")
local naughty       = require('naughty')

local module = {}

 local function keymap(...)
   local t = {}
   for _, k in ipairs({...}) do
      local but
      if type(k[1]) == "table" then
         but = awful.button(k[1], k[2], k[3])
      else
         but = awful.button({}, k[1], k[2])
      end
      t = awful.util.table.join(t, but)
   end
   return t
end
  local mouse = { LEFT = 1, MIDDLE = 2, RIGHT = 3, WHEEL_UP = 4, WHEEL_DOWN = 5 }


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
--mem_graph:connect_signal("mouse::enter", function() memory_status() end)
--mem_graph:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

mem_graph:buttons(
      keymap({ mouse.LEFT,function() memory_status() end},
      { mouse.LEFT, function()naughty.destroy(n)end }))

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()

    layout:add(mem_graph)
     
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
