local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")
local play      = require("compact.avplay.play")


local module = {}


module.aapp = {}

module.aapp["cplay"] = { command="urxvt -e /usr/home/tupoll/cplay -r Музыка ",               key="r", icon="cplay.png", }
module.aapp["ape"]    = { command="xterm -e ~/.config/awesome/compact/avplay/dr/ape.sh",     key="a", icon="ape.png", }
module.aapp["flac"]    = { command="xterm -e ~/.config/awesome/compact/avplay/dr/flac.sh",   key="f", icon="flac.png", }
module.aapp["mp3"]    = { command="xterm -e ~/.config/awesome/compact/avplay/dr/mp3.sh",     key="m", icon="mp3.png", }
module.aapp["next"]   = { command="killall avplay",                                          key="k", icon="next.png", }
module.aapp["stop"]   = { command="xterm -e ~/.config/awesome/compact/avplay/dr/stop.sh",    key="s", icon="stop.png", }

local function run(data)
    local tags = awful.tag.gettags(1)
    awful.util.spawn(data.command)
    if tags[data.tag] then awful.tag.viewonly(tags[data.tag]) end
    common.hide_menu(module.menu_aapp)
end

-- Quick menu builder
module.menu_aapp = false
function module.main_aapp()
    if not module.menu_aapp then
        module.menu_aapp = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = screen[1].geometry.width - 1300 ,
            y = screen[1].geometry.height - beautiful.wibox.height - ((#awful.util.table.keys(module.aapp))*beautiful.menu_height) - 26
        })
        for i,v in pairs(module.aapp) do
            module.menu_aapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
            --module.menu_qapp:add_key_binding({}, string.lower(v.key), function() dbg.dump(v.key) end)
            module.menu_aapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = beautiful.path.."/avplay/"..v.icon or beautiful.unknown
            })
        end
        common.reg_menu(module.menu_aapp)
    elseif module.menu_aapp.visible then
        common.hide_menu(module.menu_aapp)
    else
        common.show_menu(module.menu_aapp)
    end
end

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()   
    layout:add(common.textbox({text="avplay", width=50, b1=module.main_aapp, b3=module.main_papp}))
    layout:add(play())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })








