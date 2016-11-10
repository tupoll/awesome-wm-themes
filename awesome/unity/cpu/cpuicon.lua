local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local cpu = {}
local function worker(args)
    local args = args or {}

    widgets_table = {}
    local connected = false

    -- Settings
    local ICON_DIR      = beautiful.path.."/icons/"
    local interface     = args.interface or "cpu"
    local timeout       = args.timeout or 4
    local font          = args.font or beautiful.font
    local popup_signal  = args.popup_signal or false
    local onclick       = args.onclick
    local widget 	= args.widget == nil and wibox.layout.flex.horizontal() or args.widget == false and nil or args.widget
    local indent 	= args.indent or 5

    local cpu_icon = wibox.widget.imagebox()
    cpu_icon:set_image(ICON_DIR.."cpu0.png")
    local cpu_timer = timer({ timeout = timeout })
    local signal_level = 0
    local function cpu_update()
        signal_level = tonumber(awful.util.pread("cpu"))
        if signal_level == nil then
            connected = true         
            cpu_icon:set_image(ICON_DIR.."cpu0.png")
        else
            connected = true                       
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
    
    widgets_table["imagebox"]	= cpu_icon  
    if widget then
	    widget:add(cpu_icon)
    end   
      return widget
    
end

return setmetatable(cpu, {__call = function(_,...) return worker(...) end})
