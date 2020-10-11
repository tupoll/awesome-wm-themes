local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local box_sox    = require("compact.sox.box_sox")
local freedesktop   = require("compact.menu.freedesktop")
local screen = require("awful.screen")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern_freebsd/play/"

local module = {}

-- Main menu table

local terminal     = "urxvtc" or "xterm"


-- Quick menu table.
module.aapp = {}
module.aapp["play             r"]     = { command="zsh -c ~/.config/awesome/compact/sox/dr/play1.sh ",        key="r", icon="repeat.png"}
module.aapp["play             p"]     = { command="zsh -c ~/.config/awesome/compact/sox/dr/play.sh ",         key="p", icon="play.png"}
module.aapp["stop             s"]     = { command=" pkill -f play",         key="s", icon="stop.png"}
local function run(data)
    local tags = root.tags(1)
    awful.spawn(data.command)
    if tags[data.tag] then tag:view_only() end
    common.hide_menu(module.menu_aapp)
end

-- Quick menu builder
module.menu_aapp = false
function module.main_aapp()
    if not module.menu_aapp then
        module.menu_aapp = box_sox({
        style      = radical.style.grouped_3d,
        arrow_type = 0,
        item_style = radical.item.style.rounded,
        width = 160,
        item_width=22,
        item_height=25,
        layout = radical.layout.vertical, --horizontal,
        border_width = 2,
        --border_color = "#88aa00",
        spacing  = 0,
        bg_focus       = beautiful.menu_bg_focus or "#05021E",
        bg_normal            = beautiful.bg_normal ,
        fg_focus       = beautiful.menu_fg_focus or "#57E557",
        fg             = beautiful.menu_fg_normal or "#7F7F7F",
        item_layout = radical.layout.centerred,
        autodiscard = true,
           
        })
        for i,v in pairs(module.aapp) do
            module.menu_aapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
         --   module.menu_aapp:add_key_binding({}, string.lower(v.key), function() run(v.key) end)
            module.menu_aapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = res .. v.icon
            })
        end
        common.reg_menu(module.menu_aapp)
    elseif module.menu_aapp.visible then
        common.hide_menu(module.menu_aapp)
    else
        common.show_menu(module.menu_aapp)
    end
end

-- Return widgets layoutmodule.main_aapp 
local function new()
    local layout = wibox.layout.fixed.horizontal()   
    local widget_img,img = common.imagebox({icon=beautiful.sox_icon, b1=module.main_aapp})
    layout:add(widget_img)
    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
