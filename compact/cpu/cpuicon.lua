local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local cpu = {}

local cpu_usage  = {}
local cpu_total  = {}
local cpu_active = {}

local function worker(args)
    local args = args or {}
    -- Settings
    local ICON_DIR      = beautiful.path.."/icons/"
    local interface     = args.interface or "cpu"
    local timeout       = args.timeout or 4
    local widget 	= args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 5

    local cpu_icon = wibox.widget.imagebox()
    cpu_icon:set_image(ICON_DIR.."cpu0.png")
    cpu_icon.fit = function() return 30,5 end
    local cpu_timer = timer({ timeout = timeout })
    local signal level = 0
    local function cpu_update()
        
        local cpu_lines = {}

   -- Get CPU stats
   local f = io.open("/compat/linux/proc/stat")
   for line in f:lines() do
      if string.sub(line, 1, 3) ~= "cpu" then break end

      cpu_lines[#cpu_lines+1] = {}

      for i in string.gmatch(line, "[%s]+([^%s]+)") do
         table.insert(cpu_lines[#cpu_lines], i)
      end
   end
   f:close()

   -- Ensure tables are initialized correctly
   for i = #cpu_total + 1, #cpu_lines do
      cpu_total[i]  = 0
      cpu_usage[i]  = 0
      cpu_active[i] = 0
   end

   for i, v in ipairs(cpu_lines) do
      -- Calculate totals
      local total_new = 0
      for j = 1, #v do
         total_new = total_new + v[j]
      end
      local active_new = total_new - (v[3] + v[4])
      
      -- Calculate percentage
      local diff_total  = total_new - cpu_total[i]
      local diff_active = active_new - cpu_active[i]

      if diff_total == 0 then diff_total = 1E-6 end
      cpu_usage[i]      = math.floor((diff_active / diff_total) * 100)
        cpu_total[i]   = total_new
      cpu_active[i]  = active_new
   end
 
      signal_level = cpu_usage[2] 
        if signal_level == nil then                 
            cpu_icon:set_image(ICON_DIR.."cpu0.png")
        else                                
            if signal_level < 3 then
                cpu_icon:set_image(ICON_DIR.."cpu1.png")
            elseif signal_level < 30 then
                cpu_icon:set_image(ICON_DIR.."cpu2.png")
            elseif signal_level < 50 then
                cpu_icon:set_image(ICON_DIR.."cpu3.png")
            elseif signal_level < 70 then
                cpu_icon:set_image(ICON_DIR.."cpu4.png")
            elseif signal_level < 90 then
                cpu_icon:set_image(ICON_DIR.."cpu5.png")
            elseif signal_level < 100 then
                cpu_icon:set_image(ICON_DIR.."cpu6.png")
            else            
                cpu_icon:set_image(ICON_DIR.."cpu6.png")
            end
        end    
end

    cpu_update()
    cpu_timer:connect_signal("timeout", cpu_update)
    cpu_timer:start()
 
    widget:add(cpu_icon)
       
      return widget
    
end

return setmetatable(cpu, {__call = function(_,...) return worker(...) end})
