local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")


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
        module.menu_eapp = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = screen[1].geometry.width - 0,
            y = screen[1].geometry.height - beautiful.wibox.width - ((#awful.util.table.keys(module.eapp))*beautiful.menu_height) - 0
        })
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
    local layout = wibox.layout.flex.horizontal()
    layout:add(common.imagebox({icon=beautiful.path.."/logos/awesome.png", b1=module.main_eapp, b3=module.main_eapp}))
   -- layout:add(common.textbox({text="ВЫХОД", width=50, b1=module.main_eapp, b3=module.main_eapp }))
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
