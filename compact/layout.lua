local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local common    = require("unity.common")

local module = {}

-- Layouts table
module.layouts = {
    awful.layout.suit.magnifier,         -- 1
    awful.layout.suit.tile,              -- 2
    awful.layout.suit.tile.left,         -- 3
    awful.layout.suit.tile.bottom,       -- 4
    awful.layout.suit.tile.top,          -- 5
    awful.layout.suit.fair,              -- 6
    awful.layout.suit.fair.horizontal,   -- 7
    awful.layout.suit.spiral,            -- 8
    awful.layout.suit.spiral.dwindle,    -- 9
    awful.layout.suit.max,               -- 10
    awful.layout.suit.max.fullscreen,    -- 11
    awful.layout.suit.floating,          -- 12
}


-- Menu
module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = 10,
            y = screen[1].geometry.height - beautiful.wibox.height - (#module.layouts*beautiful.menu_height) - 28
        })
        local current = awful.layout.get(awful.tag.getscreen(awful.tag.selected()))
        for i, layout_real in ipairs(module.layouts) do
            local layout_name = awful.layout.getname(layout_real)
            if layout_name then
                module.menu:add_item({
                    icon = beautiful.path.."/layouts/"..layout_name..".png",
                    text = layout_name:gsub("^%l", string.upper), -- Changes the first character of a word to upper case
                    button1 = function()
                        awful.layout.set(module.layouts[module.menu.current_index] or module.layouts[1], awful.tag.selected())
                        common.hide_menu(module.menu)
                    end,
                    selected = (layout_real == current),
                    underlay = i,
                })
            end
        end
        common.reg_menu(module.menu)
    elseif module.menu.visible then
        common.hide_menu(module.menu)
    else
        common.show_menu(module.menu)
    end
end

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    local widget,img = common.imagebox({icon=beautiful.path.."/layouts/"..awful.layout.getname(awful.layout.get(1))..".png" })
    local function update_layout_icon()
        img:set_image(beautiful.path.."/layouts/"..awful.layout.getname(awful.layout.get(1))..".png")
    end

    awful.tag.attached_connect_signal(1, "property::selected", update_layout_icon)
    awful.tag.attached_connect_signal(1, "property::layout",   update_layout_icon)
    layout:add(widget)
    layout:add(common.textbox({ text="LAYOUT", width=60, b1=module.main }))
    
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
