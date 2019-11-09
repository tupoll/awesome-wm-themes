local awful     = require("awful")
local radical   = require("radical")
local beautiful = require("beautiful")
local titlebar  = require("compact.titlebar")

local module = {}

module.style = radical.style.classic
--module.item_style = radical.item_style.classic

local function hideMenu()
    if module.menu then
        module.menu.visible = false
    end
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
        awful.button({ }, 3, function(c) awful.menu.client_list({ theme = { width = 250 } })end),
        awful.button({ }, 2, function(c) c:kill() end)
    )
    
    return awful.widget.tasklist(1, awful.widget.tasklist.filter.currenttags, buttons, beautiful.task)
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
