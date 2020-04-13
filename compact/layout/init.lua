local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local radical   = require("radical")
local item      = require("radical.item")
local common    = require("compact.common.helpers1")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/layouts/"
local layoutlist = require("compact.layout.layoutlist")

local module = {}

-- Menu
module.menu = false
function module.main()
    if not module.menu then
        module.menu = awful.popup {        
        widget = layoutlist {
        screen      = 1,
        visible     = true,        
        base_layout = wibox.layout.flex.vertical        
    },
    maximum_height = #awful.layout.layouts * 24,
    minimum_height = #awful.layout.layouts * 24,
    placement      = awful.placement.bottom_left,
    timeout = 0,    
    ontop = true,
}

function layout_up() awful.layout.inc(1) end

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
    local widget_img,img = common.imagebox({icon=res .. awful.layout.getname(awful.layout.get(1))..".png" })
    local function update_layout_icon()
        img:set_image(res .. awful.layout.getname(awful.layout.get(1)) .. ".png")
    end
    local widget_txt,text = common.textbox({text="LAYOUT", width=60, b1=module.main, b3= function (_,  main) awful.layout.inc( -1) end})

    awful.tag.attached_connect_signal(1, "property::selected", update_layout_icon)
    awful.tag.attached_connect_signal(1, "property::layout",   update_layout_icon)
    layout:add(widget_img)
    layout:add(widget_txt)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
