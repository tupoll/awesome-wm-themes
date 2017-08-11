local wibox         = require("wibox")
local awful         = require("awful")
local naughty       = require('naughty')
local beautiful     = require("beautiful")
local memory = {}
local function worker(args)
    local args = args or {}

    -- Settings
    local ICON_DIR      = beautiful.path.."/icons/"
    local interface     = args.interface or "memory"
    local timeout       = args.timeout or 5
    local widget 	= args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 3

    local mem_icon = wibox.widget.imagebox()
    mem_icon:set_image(ICON_DIR.."mem0.png")
    mem_icon.fit = function() return 30,10 end
    local mem_timer = timer({ timeout = timeout })
    local v = 0
    local function mem_update()
    local _mem = { buf = {} }
         for line in io.lines("/compat/linux/proc/meminfo") do
      for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
         if     k == "MemTotal"  then _mem.total = math.floor(v/1024)
         elseif k == "MemFree"   then _mem.buf.f = math.floor(v/1024)
         elseif k == "Buffers"   then _mem.buf.b = math.floor(v/1024)
         elseif k == "Cached"    then _mem.buf.c = math.floor(v/1024)
         end
      end
   end

   -- Calculate memory percentage
   _mem.free  = _mem.buf.f + _mem.buf.b + _mem.buf.c
   _mem.inuse = _mem.total - _mem.free
   _mem.usep  = math.floor(_mem.inuse / _mem.total * 100)
    
        if _mem.usep == nil then                 
            mem_icon:set_image(ICON_DIR.."mem0.svg")
        else                                
            if _mem.usep < 10 then
                mem_icon:set_image(ICON_DIR.."mem0.svg")
            elseif _mem.usep < 20 then
                mem_icon:set_image(ICON_DIR.."mem1.svg")
            elseif _mem.usep < 30 then
                mem_icon:set_image(ICON_DIR.."mem2.svg")
            elseif _mem.usep < 40 then
                mem_icon:set_image(ICON_DIR.."mem3.svg")
            elseif _mem.usep < 50 then
                mem_icon:set_image(ICON_DIR.."mem4.svg")
            elseif _mem.usep < 70 then
                mem_icon:set_image(ICON_DIR.."mem5.svg")
            elseif _mem.usep < 100 then
                mem_icon:set_image(ICON_DIR.."mem6.svg")
            else            
                mem_icon:set_image(ICON_DIR.."mem6.svg")
            end
        end    
end

    mem_update()
    mem_timer:connect_signal("timeout", mem_update)
    mem_timer:start()
 
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
mem_icon:connect_signal("mouse::enter", function() memory_status() end)
mem_icon:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
     
	    widget:add(mem_icon)
       
      return widget    
end

return setmetatable(memory, {__call = function(_,...) return worker(...) end})
