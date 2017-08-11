local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local gears     = require("gears")
local cairo     = require("lgi").cairo

local module = {}
module.timer = {}

--- Register new menu timer
-- @param m menu to register
function module.reg_menu(m)
    local timeout = beautiful.menu_timeout or 10
    for vm,_ in pairs(module.timer) do
        if vm.visible then module.hide_menu(vm) end
    end
    module.timer[m] = timer{ timeout = timeout }
    module.timer[m]:connect_signal("timeout", function() module.hide_menu(m) end)
    module.timer[m]:start()
    m.visible = true
end

--- Hide menu and stop timer
-- @param m menu to hide
function module.hide_menu(m)
    module.timer[m]:stop()
    m.visible = false
end

--- Show menu and start timer
-- @param m menu to show
function module.show_menu(m)
    for vm,_ in pairs(module.timer) do
        if vm.visible then module.hide_menu(vm) end
    end
    module.timer[m]:start()
    m.visible = true
end

--- Create new imagebox widget
-- @param table with arguments {icon, bg, b1, b2}
-- @returns background widget, image widget
function module.imagebox(args)
    local args = args or {}
    local imagewidget  = wibox.widget.imagebox()
    local background = wibox.container.background()
    local bg = args.bg or beautiful.widget["bg"] or "#00121E"
    local b1 = args.b1 or nil
    local b3 = args.b3 or nil

    if args.icon then imagewidget:set_image(args.icon) end
    imagewidget:buttons(awful.util.table.join(awful.button({ }, 1, b1), awful.button({ }, 3, b3)))
    background:set_widget(imagewidget)
    background:set_bg(bg)

    return background,imagewidget
end

--- Create new textbox widget
-- @param table with arguments {text, width, height, font, valign, align, bg, fg, b1, b2}
-- @return background widget, text widget
function module.textbox(args)
    local args = args or {}
    local text = args.text or "N/A"
    local width = args.width or 40
    local height = args.height or 16
    local font = args.font or beautiful.widget["font"] or "sans 8"
    local valign = args.valign or beautiful.widget["valign"] or "center"
    local align = args.valign or beautiful.widget["align"] or "center"
    local bg = args.bg or beautiful.widget["bg"] or "#00121E"
    local fg = args.fg or beautiful.widget["fg"] or "#1692D0"

    -- Mouse buttons
    local b1 = args.b1 or nil
    local b3 = args.b3 or nil

    local background  = wibox.container.background()
    local textwidget = wibox.widget.textbox()

    textwidget:set_markup("<span color='"..fg.."'>"..text.."</span>")
    textwidget:set_align(align)
    textwidget:set_valign(valign)
    textwidget:set_font(font)
    textwidget.fit = function() return width,height end

    textwidget:buttons(awful.util.table.join(awful.button({ }, 1, b1),awful.button({ }, 3, b3)))

    background:set_widget(textwidget)
    background:set_bg(bg)

    background:connect_signal("mouse::enter", function()
        textwidget:set_markup("<span color='"..fg.."'><b>"..text.."</b></span>")
    end)
    background:connect_signal("mouse::leave", function()
        textwidget:set_markup("<span color='"..fg.."'>"..text.."</span>")
    end)

    return background,textwidget
end

--- Arrow widget
-- @param n arrow number
local arrowWidget = {}
function module.arrow(n)
    if arrowWidget[n] then
        return arrowWidget[n]
    else
        local imagewidget = wibox.widget.imagebox()
        imagewidget:set_image(beautiful.path.."/arrow/"..n..".png")
        arrowWidget[n] = imagewidget
        return arrowWidget[n]
    end
end

local function new()
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
