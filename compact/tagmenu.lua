local wibox     = require("wibox")
local awful     = require("awful")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")




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
--awful.tag.setproperty(tags[1], "mwfact", 0.60)
--[[
-- Read tag history file
function module.selected()
    local f = io.open(module.history, "r")
    if f ~= nil then
        local idx = f:read("*all")
        f:close()
        
    end
end

--]]
-- Try to restore last visible tag
--module.selected()

-- Main menu
module.menu=false
function module.main()
    if not module.menu then
        local tags = awful.tag.gettags(1)
        module.menu = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = 180,
            y = screen[1].geometry.height - beautiful.wibox.height - (#tags*beautiful.menu_height) - 22
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
--[[
-- Signal just before awesome exits 
-- Perform some actions before restarting/exiting awesome wm.
awesome.connect_signal("exit", function(restarting)
    if restarting then
        -- Save last visible tag
        local f = io.open(module.history, "w")
        f:write(awful.tag.getidx(awful.tag.selected(1)))
        f:close()
        -- Now restart!
        awful.util.restart()
    end
end)
--]]
-- Return widget layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local style = beautiful.tag or {}
    local buttons = awful.util.table.join(
        awful.button({        }, 1, awful.tag.viewonly),
        awful.button({ "Mod4" }, 1, awful.client.movetotag),
        awful.button({        }, 3, awful.tag.viewtoggle),
        awful.button({ "Mod4" }, 3, awful.client.toggletag))
    layout:add(common.imagebox({icon=beautiful.path.."/widgets/workspace.svg"}))
    layout:add(common.textbox({text="TAG", width=35, b1=module.main}))
  --  layout:add(awful.widget.taglist(1, awful.widget.taglist.filter.noempty, buttons, style))
   -- layout:add(common.arrow(2))
    return layout
end



return setmetatable(module, { __call = function(_, ...) return new(...) end })
