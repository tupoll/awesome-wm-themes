local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")

 local titlebars_enabled = false
  local module = {}

  local function new(c)
    -- Layouts
    local left_layout = wibox.layout.fixed.horizontal()
    local right_layout = wibox.layout.fixed.horizontal()
    local middle_layout = wibox.layout.flex.horizontal()

    -- Buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )
    -- Status images
    if beautiful.titlebar["status"] then
        local status_image = wibox.widget.imagebox()
        local status_layout = wibox.layout.fixed.horizontal()

        local function update_titlebar_status_icons()
            local s=""
            if c.sticky == true then s = s.."_sticky"  end
            if c.ontop == true then  s = s.."_ontop"   end
            if awful.client.floating.get(c) then s = s.."_float" end
            status_image:set_image(beautiful.path .. "/titlebar/status"..s..".png")
        end
        update_titlebar_status_icons(c)
        c:connect_signal("property::floating", update_titlebar_status_icons)
        c:connect_signal("property::ontop", update_titlebar_status_icons)
        c:connect_signal("property::sticky", update_titlebar_status_icons)
        
        status_layout:add(status_image)
        status_layout:buttons(buttons)
        right_layout:add(status_layout)
    end

    -- Client icon
    local clientIcon = wibox.widget.imagebox()
    clientIcon:set_image(c.icon or beautiful.unknown)

    -- Titlebar title
    local clientTitle = wibox.widget.textbox()
    clientTitle:set_valign(beautiful.titlebar["valign"])
    clientTitle:set_font(beautiful.titlebar["font"])
    local function update_titlebar_text()
        local text = awful.util.linewrap(awful.util.escape(c.name) or "N/A", 80)
        clientTitle:set_markup("<span color='".. beautiful.titlebar["fg"] .."'>".. text .."</span>")
    end
    c:connect_signal("property::name", update_titlebar_text)
    update_titlebar_text()

    left_layout:add(clientIcon)
    left_layout:add(clientTitle)
    left_layout:buttons(buttons)

    -- Empty middle layout (it is required for buttons)
    middle_layout:buttons(buttons)

    -- Titlebar buttons
    right_layout:add(awful.titlebar.widget.floatingbutton(c))
    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    right_layout:add(awful.titlebar.widget.stickybutton(c))
    right_layout:add(awful.titlebar.widget.ontopbutton(c))
    right_layout:add(awful.titlebar.widget.closebutton(c))

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(middle_layout)
    layout:set_right(right_layout)
    awful.titlebar(c, { size = beautiful.titlebar["size"], position = beautiful.titlebar["position"],
        bg_normal = beautiful.titlebar["bg"],bg_focus = beautiful.titlebar["bg_focus"]}):set_widget(layout)
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })

