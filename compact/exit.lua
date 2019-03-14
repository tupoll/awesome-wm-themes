local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local placement = require( "awful.placement" )

local module = {}

-- Quick menu table.
module.eapp = {}

module.eapp["reboot"] = { command="sudo /sbin/reboot", key="r", icon="gnome-session-reboot.svg", }
module.eapp["shutdown"] = { command="sudo /sbin/poweroff", key="s", icon="gnome-session-hibernate.svg", }


local function run(data)
    local tags = awful.tag.gettags(1)
    awful.util.spawn(data.command)
    if tags[data.tag] then awful.tag.viewonly(tags[data.tag]) end
    common.hide_menu(module.menu_eapp)
end

-- Quick menu builder
module.menu_eapp = false
function module.main_eapp()
    if not module.menu_eapp then
        module.menu_eapp = radical.box_br({
        style      = radical.style.grouped_3d,
        arrow_type = 0,
        item_style = radical.item.style.grouped_3d,
        width = 100,
        layout = radical.layout.vertical, --horizontal,
        --border_width = 2,
        --border_color = "#88aa00",
        spacing  = 0,
        bg_focus       = beautiful.menu_bg_focus or "#05021E",
        bg_normal            = beautiful.bg_normal ,
        fg_focus       = beautiful.menu_fg_focus or "#57E557",
        fg             = beautiful.menu_fg_normal or "#7F7F7F",
        item_layout = radical.layout.centerred,
        autodiscard = true
        
        })
        module.menu_eapp .margins.top = 3
        module.menu_eapp.margins.bottom = 3
        
         
        for i,v in pairs(module.eapp) do
            module.menu_eapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
            --module.menu_qapp:add_key_binding({}, string.lower(v.key), function() dbg.dump(v.key) end)
            module.menu_eapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = beautiful.path.."/launcher/exit/"..v.icon or beautiful.unknown
            })
        end
        common.reg_menu(module.menu_eapp)
    elseif module.menu_eapp.visible then
        common.hide_menu(module.menu_eapp)
    else
        common.show_menu(module.menu_eapp)
    end
end

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget_img,img = common.imagebox({icon=beautiful.path.."/logos/awesome.png"})
    local widget_txt,text = common.textbox({text="ВЫХОД", width=50, b1=module.main_eapp, b3=module.main_eapp })
    local widget_txt1,text = common.textbox({text="   ", width=50 })
    local widget_txt2,text = common.textbox({text=" ", width=650 })
    layout:add(widget_img, widget_txt, widget_txt1, widget_txt2)         
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
