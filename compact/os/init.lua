local wibox      = require("wibox")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local timer     = require("gears.timer")
local os_txt    = require("compact.os.os_txt")
local box_bl    = require("compact.avplay.box_bl")
local beautiful = require("beautiful")

local module = {}

module.oapp = {}

module.oapp["Linux"] = { command="'zsh' '-c' 'urxvt -e ~/.config/awesome/compact/os/make_linux.sh'",               key="l", icon="start-here-gentoo4.png", }
module.oapp["FreeBSD"]    = { command="'zsh' '-c' 'urxvt -e ~/.config/awesome/compact/os/make_freebsd.sh'",     key="f", icon="free_bsd.png", }
module.oapp["DragonFly"]    = { command="urxvt -e notify-send 'DragonFlyBSD'",   key="d", icon="dragonfly-3.png", }


local function run(data)
    local tags = root.tags(1)
    awful.spawn(data.command)
    if tags[data.tag] then tag:view_only() end
    common.hide_menu(module.menu_oapp)
end

-- Quick menu builder
module.menu_oapp = false
function module.main_oapp()
    if not module.menu_oapp then
        module.menu_oapp = box_bl({
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
        for i,v in pairs(module.oapp) do
            module.menu_oapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
         --   module.menu_aapp:add_key_binding({}, string.lower(v.key), function() run(v.key) end)
            module.menu_oapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = beautiful.path.."/logos/"..v.icon or beautiful.unknown
            })
        end
        common.reg_menu(module.menu_oapp)
    elseif module.menu_oapp.visible then
        common.hide_menu(module.menu_oapp)
    else
        common.show_menu(module.menu_oapp)
    end
end

  
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget_txt,text = common.textbox({text="  OS-", width=30 ,b1=module.main_oapp })    
    layout:add(widget_txt)
    layout:add(os_txt())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })