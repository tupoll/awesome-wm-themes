local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local vicious = require("vicious")
local blingbling = require("blingbling")
local cpu = require("vicious.widgets.cpu_dragonfly") 

local module = {}

local tmp_usage = cpu.tmp_usage
 cpu_graph = blingbling.line_graph({ height = 28,
                                      width = 60,
                                      show_text = true,
                                      text_color = "#E5E5E5",
                                      graph_line_color = "#8B6914",
                                      graph_color = "#8B6914",
                                      label = "CPU: $percent %",
                                      graph_background_color = "#00000000",
                                      text_background_color = "#00000000",
                                      text_color = "#7F7F7F",
                                      font = 'Terminus Bold',
                                      font_size = 10 })
                                     
cpu_graph.fit = function() return 60,5 end
vicious.register(cpu_graph, vicious.widgets.cpu,'$1',2)  
 
-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()         
    layout:add(cpu_graph)
     
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
