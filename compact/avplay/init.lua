local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local box_bl    = require("compact.avplay.box_bl")
local play      = require("compact.avplay.play")

local module = {}


module.aapp = {}

module.aapp["cplay"] = { command="urxvt -e /usr/home/tupoll/cplay -r Музыка ",               key="r", icon="cplay.png", }
module.aapp["ape"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/ape.sh",     key="a", icon="ape.png", }
module.aapp["flac"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/flac.sh",   key="f", icon="flac.png", }
module.aapp["mp3"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/mp3.sh",     key="m", icon="mp3.png", }
module.aapp["next"]   = { command="killall avplay",                                          key="k", icon="next.png", }
module.aapp["stop"]   = { command="zsh -c ~/.config/awesome/compact/avplay/dr/stop.sh",    key="s", icon="stop.png", }
module.aapp["media_ape"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/media_ape.sh",     key="2", icon="ape.png", }
module.aapp["media_flac"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/media_flac.sh",   key="1", icon="flac.png", }
module.aapp["media_mp3"]    = { command="zsh -c ~/.config/awesome/compact/avplay/dr/media_mp3.sh",     key="3", icon="mp3.png", }

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
        module.menu_aapp = box_bl({
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
    local widget_txt,text = common.textbox({text="avplay", width=50, b1=module.main_aapp, b3=module.main_papp})  
    layout:add(widget_txt)
    layout:add(play())
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })








