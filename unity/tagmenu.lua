local wibox     = require("wibox")
local awful     = require("awful")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("unity.common")

local module = {}

-- Tags table.
module.tag = {
    { name="𝟏",             sname="1", icon="files.png",              }, -- 1
    { name="𝟐",             sname="2", icon="reader.svg",             }, -- 2
    { name="𝟑",             sname="3", icon="network.svg",            }, -- 3
    { name="𝟒",             sname="4", icon="graphics.svg",           }, -- 4
    { name="𝟓",             sname="5", icon="development.svg",        }, -- 5   
    { name="𝟔",             sname="6", icon="multimedia.svg",         }, -- 6    
}   

-- Main menu
module.menu=false
function module.main()
    if not module.menu then
        local tags = awful.tag.gettags(1)
        module.menu = radical.context({
            filer = false, enable_keyboard = true, direction = "right", x = 1075,
            y = screen[1].geometry.height - beautiful.wibox.width - (#tags*beautiful.menu_height) - 380
        })
        for i,t in ipairs(tags) do
            module.menu:add_item({
                button1 = function() awful.tag.viewonly(t) common.hide_menu(module.menu) end,
                selected = (t == awful.tag.selected(1)),
                text = module.tag[i].name,
                icon = beautiful.path.."/tags/"..module.tag[i].icon,
                underlay = string.upper(module.tag[i].sname)
            })
        end
        common.reg_menu(module.menu)
    elseif module.menu.visible then
        common.hide_menu(module.menu)
    else
        common.show_menu(module.menu)
    end
end



return setmetatable(module, { __call = function(_, ...) return new(...) end })
