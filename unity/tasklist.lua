local awful     = require("awful")
local radical   = require("radical")
local beautiful = require("beautiful")
local tags      = require("unity.tagmenu")
local titlebar  = require("unity.titlebar")


local module = {}

--module.style = radical.style.classic
--module.item_style = radical.item_style.classic

local function hideMenu()
    if module.menu then
        module.menu.visible = false
    end
end

-- Move client to tag
local function move2tag(c)
    local items = radical.context({enable_keyboard = false, style = module.style, item_style = module.item_style})
    local gt = awful.tag.gettags(1)
    for i, _ in ipairs(gt) do
        items:add_item({
            text = tags.tag[i].name,
            button1 = function() awful.client.movetotag(gt[i], c) hideMenu() end,
            icon = beautiful.path.."/tags/"..tags.tag[i].icon,
            underlay = string.upper(tags.tag[i].sname)
        })
    end
    return items
end

-- Create items
local function items(c,m)
    local c = c or client.focus
    -- Move to tag
    m:add_item({ text = "Move to tag", icon = beautiful.path.."/client/move.svg", sub_menu=move2tag(c) })
    -- Add titlebar
    -- titlebar state
    m:add_item({ text = "Add titlebar", icon = beautiful.path.."/client/titlebar.svg",
        button1 = function() titlebar(c) hideMenu() end
    })
    -- Ontop
    m:add_item({ text = "Ontop", icon = beautiful.path.."/client/ontop.svg",
        checked = c.ontop, button1 = function() c.ontop = not c.ontop hideMenu() end
    })
    -- Sticky
    m:add_item({ text = "Sticky", icon = beautiful.path.."/client/sticky.svg",
        checked = c.sticky, button1 = function() c.sticky = not c.sticky hideMenu() end
    })
    -- Above
    m:add_item({ text = "Above", icon = beautiful.path.."/client/above.svg",
        checked = c.above, button1 = function() c.above = not c.above hideMenu() end
    })
    -- Below
    m:add_item({ text = "Below", icon = beautiful.path.."/client/below.svg",
        checked = c.below, button1 = function() c.below = not c.below hideMenu() end
    })
    -- Floating
    m:add_item({ text = "Floating", icon = beautiful.path.."/client/floating.svg",
        checked = awful.client.floating.get(c),
        button1 = function()
            if awful.client.floating.get(c) then
                awful.client.floating.delete(c)
            else
                awful.client.floating.toggle(c)
            end
            hideMenu()
        end
    })
    -- fullscreen
    --m:add_item({ text = "Fullscreen", icon = beautiful.path.."/client/fullscreen.svg",
    --    checked = c.fullscreen, button1 = function() c.fullscreen = not c.fullscreen hideMenu() end
    --})
    -- Maximize
    m:add_item({ text = "Maximize", icon = beautiful.path.."/client/maximize.svg",
        checked = function()
            if c.maximized_horizontal or c.maximized_vertical then
                return true
            else
                return false 
            end
        end,
        button1 = function()
            if c.maximized_horizontal or c.maximized_vertical then
                c.maximized_horizontal = false
                c.maximized_vertical = false
            else
                c.maximized_horizontal = true
                c.maximized_vertical = true
                awful.client.floating.delete(c)
            end
            hideMenu()
        end
    })
    -- Save
    m:add_item({ text = "Save", icon = beautiful.path.."/client/save.svg",
        underlay = "SQL", button1 = function() awful.clientdb.save(c) hideMenu() end
    })
    -- Close
    m:add_item({ text = "Close", icon = beautiful.path.."/client/close.svg",
        underlay = c.pid, button1 = function() c:kill() hideMenu() end
    })
end

module.menu = false
function module.main(c)
    if module.menu and module.menu.visible then
        hideMenu()
        keygrabber.stop()
    else
        module.menu = radical.context({ enable_keyboard = true, style = module.style, item_style = module.item_style })
        items(c, module.menu)
        module.menu.visible = true
    end
end

local function new()
    client.connect_signal("list", hideMenu)
    client.connect_signal("focus", hideMenu)
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function(c)
            if module.menu and module.menu.visible then hideMenu() end
            if c == client.focus then
                c.minimized = true
            else
                c.minimized = false
                client.focus = c
                c:raise()
            end
        end),
        awful.button({ }, 3, function(c) module.main(c) end),
        awful.button({ }, 2, function(c) c:kill() end)
    )
    return awful.widget.tasklist(1, awful.widget.tasklist.filter.currenttags, buttons, beautiful.task)
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
