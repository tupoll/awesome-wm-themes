local wibox     = require("wibox")
local awful     = require("awful")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")




local module = {}
-- /dev/shm is a temporary file storage filesystem, i.e. tmpfs, that uses RAM for the backing store.
--module.history = "/dev/shm/history_tag"
module.history = awful.util.getdir("cache").."/history_tag"

-- Tags table.
-- Tags table.
module.tag = {
    { name="𝟏",             sname="1", icon="files.png",              }, -- 1
    { name="𝟐",             sname="2", icon="reader.svg",             }, -- 2
    { name="𝟑",             sname="3", icon="network.svg",            }, -- 3
    { name="𝟒",             sname="4", icon="graphics.svg",           }, -- 4
    { name="𝟓",             sname="5", icon="development.svg",        }, -- 5   
    { name="𝟔",             sname="6", icon="multimedia.svg",         }, -- 6    
}   

-- Setup tags
local tags = awful.tag.gettags(1)


-- Main menu
module.menu=false
function module.main()
    if not module.menu then
        local tags = awful.tag.gettags(1)
        module.menu = radical.box({
        style      = grouped_3d     ,
        item_style = radical.item.style.line_3d ,
        item_height = 18,--48,
        width = 140,
        layout = radical.layout.vertical, --horizontal,
        border_width = 2,
        border_color = "#88aa00",
        spacing  = 4,     
        enable_keyboard = false,
        item_layout = radical.layout.centerred        
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

-- Signal when client looses tag. 
-- Check if there is no more clients, if true then go to the previous tag.
client.connect_signal("untagged", function(_, t)
    if awful.tag.selected() == t and #t:clients() == 0 then
        awful.tag.history.restore()
    end
end)


-- Return widget layout



return setmetatable(module, { __call = function(_, ...) return (...) end })
