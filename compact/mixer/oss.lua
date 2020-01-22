-------------------------------------------------
-- Volume Widget for Awesome Window Manager
-- Shows the current volume level
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget

-- @author Pavel Makhov
-- @copyright 2018 Pavel Makhov
--for freebsd fixed tupoll 2020
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local dpi = require('beautiful').xresources.apply_dpi
local gears = require("gears")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/mixer/"

local volume_widget = {}

local function worker(args)

    local args = args or {}

    local volume_audio_controller = args.volume_audio_controller or 'pulse'
    local display_notification = args.notification or 'false'
    local position = args.notification_position or "top_right"


    local GET_VOLUME_CMD = 'mixer vol' 
    local INC_VOLUME_CMD = 'mixer vol +3'
    local DEC_VOLUME_CMD = 'mixer vol -3'
    local TOG_VOLUME_CMD = 'mixer vol 0'

    
    local timeout       = args.timeout or 1   
    local widget    = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent    = args.indent or 3
    local volume_widget = wibox.widget.imagebox()
    local volume_timer = gears.timer({ timeout = timeout })
    local function vol_update()   
        spawn.easy_async(cmd, function(stdout, _, _, _, stderr, reason, exit_code)
         cmd = tonumber(string.format("% 3d", stdout))

        if cmd == mute then                   
            volume_widget:set_image(res .. "audio-volume-muted-panel.svg")
        else                      
             if cmd < 1 then
                volume_widget:set_image(res .. "audio-volume-muted-panel.svg")
            elseif cmd < 30 then
                volume_widget:set_image(res .. "audio-output-none-panel.svg")
            elseif cmd < 50 then
                volume_widget:set_image(res .. "audio-volume-zero-panel.svg")
            elseif cmd < 70 then
                volume_widget:set_image(res .. "audio-volume-low-panel.svg")
            elseif cmd < 90 then
                volume_widget:set_image(res .. "audio-volume-medium-panel.svg")
            elseif cmd < 100 then
                volume_widget:set_image(res .. "audio-volume-high-panel.svg")
            else            
                volume_widget:set_image(res .. "audio-volume-high-panel.svg")
            end
        end
     end)       
end

    vol_update()
    volume_timer:connect_signal("timeout", vol_update)
    volume_timer:start()       

    local notification = {}
    local volume_icon_name="audio-volume-high-panel"

    local function get_notification_text(txt)
        local mute = string.match(txt, "%[(o%a%a?)%]")
        local volume = string.match(txt, "%d+")
        volume = tonumber(string.format("% d", volume))
        if mute == "off" then
            return volume.."% <span color=\"red\"><b>Mute</b></span>"
        else
            return volume .."%"
        end
    end

    local function show_volume(val)
        spawn.easy_async(GET_VOLUME_CMD,
        function(stdout, _, _, _)
            notification = naughty.notify{                
                text =  get_notification_text(stdout),                
                icon = res .. val .. ".svg",
                title = "Volume",
                position = "bottom_right",
                timeout = 0, hover_timeout = 0.5,
                width = 200,
            }
        end
        )
    end
        
    local update_graphic = function(widget, stdout, _, _, _)
        local mute = string.match(stdout, "%[(o%D%D?)%]")
        local volume = string.match(stdout, "%d+")
        volume = tonumber(string.format("% d", volume))
        if mute == "off" then volume_icon_name="audio-volume-muted_red"
        elseif (volume >= 0 and volume < 10) then volume_icon_name="audio-volume-muted-panel"
        elseif (volume < 25) then volume_icon_name="audio-output-none-panel"
        elseif (volume < 50) then volume_icon_name="audio-volume-low-panel"
        elseif (volume < 85) then volume_icon_name="audio-volume-medium-panel"
        elseif (volume <= 100) then volume_icon_name="audio-volume-high-panel"
        end
        widget.image = res .. volume_icon_name .. ".svg"
        if display_notification then
            notification.iconbox.image = res .. volume_icon_name .. ".svg"
            naughty.replace_text(notification, "Volume", get_notification_text(stdout))
        end
    end
    
    --[[ allows control volume level by:
    - clicking on the widget to mute/unmute
    - scrolling when cursor is over the widget
    ]]
    volume_widget:connect_signal("button::press", function(_,_,_,button)
        if (button == 4)     then spawn(INC_VOLUME_CMD, false)
        elseif (button == 5) then spawn(DEC_VOLUME_CMD, false)
        elseif (button == 1) then spawn(TOG_VOLUME_CMD, false)
        end

        spawn.easy_async(GET_VOLUME_CMD, function(stdout, stderr, exitreason, exitcode)
            update_graphic(volume_widget, stdout, stderr, exitreason, exitcode)
        end)
    end)

    if display_notification then
        volume_widget:connect_signal("mouse::enter", function() show_volume(volume_icon_name) end)
        volume_widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
    end
    watch(GET_VOLUME_CMD, 1, update_graphic, volume_widget)
    
    return volume_widget
end

return setmetatable(volume_widget, { __call = function(_, ...) return worker(...) end })
