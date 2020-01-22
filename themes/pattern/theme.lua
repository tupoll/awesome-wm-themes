local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi
local os, math, string = os, math, string
local cairo   = require("lgi").cairo

-- Create cairo pattern from png file
local function pattern(image)
    local pat = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(image))
    cairo.Pattern.set_extend(pat,cairo.Extend.REPEAT)
    return pat
end

local theme                            = {}
theme.path                            = awful.util.getdir("config").."/themes/pattern"
local res                              = os.getenv("HOME") .. "/.config/awesome/themes/pattern"
theme.wallpaper                        = res .. "/3D_black_background_8.jpg"
theme.menu_submenu_icon                = res .. "/icons/submenu.png"
theme.distr_icon                       = res .. "/logos/funtoo_logo1.png"
theme.icon_theme                      = nil

-- {{{ Styles
theme.font                            = "Roboto Medium 8"
theme.bg_normal                       = "#0A1535"
theme.bg_focus                        = "#003687"
theme.bg_urgent                       = "#1A1A1A"
theme.bg_minimize                     = "#040A1A"
theme.bg_highlight                    = "#0E2051"
theme.bg_alternate                    = "#043A88"
theme.fg_normal                       = "#BFBFBF"
theme.fg_focus                        = "#BFBFBF"
theme.fg_urgent                       = "#FF7777"
theme.fg_minimize                     = "#1577D3"
theme.border_width                    = dpi(1)
theme.border_color                    = "#1577D3"
theme.border_normal                   = "#000000"
theme.border_focus                    = "#00346D"
theme.border_marked                   = "#FFF200"
theme.border_tagged                   = "#8B6914"
-- {{{ Menu
theme.menu_height                     = dpi(18)
theme.menu_width                      = dpi(120)
theme.menu_border_width               = dpi(1)
theme.menu_border_color               = "#7F7F7F"
theme.menu_fg_normal                  = "#BFBFBF"
theme.menu_bg_normal                  = pattern(res.."/background/radical.png")
theme.menu_bg_focus                   = pattern(res.."/background/radical_focus.png")
theme.menu_fg_focus                   = "#FFC0CB"
theme.menu_bg_header                  = pattern(res.."/background/radical_header.png")
theme.menu_bg_highlight               = pattern(res.."/background/radical_highlight.png")
theme.menu_bg_alternate               = "#98732F"
theme.tooltip_bg                      = pattern(res.."/background/tooltip.png")
theme.tooltip_fg                      = "#7F7F7F"
-- }}}
-- Main wibox settings
theme.wibox={}
theme.wibox.position                  = "bottom"
theme.wibox.height                    = dpi(24)
theme.wibox.bg                        = pattern(res.."/background/wibox.png")
theme.wibox.fg                        = "#7F7F7F"

-- Text widget
theme.widget={}
theme.widget["font"]                  = "Roboto Medium 8"
theme.widget["fg"]                    = "#7F7F7F"
theme.widget["bg"]                    = "00000000"   --pattern(res.."/background/wibox.png")
theme.widget["align"]                 = "center"
theme.widget["valign"]                = "center"

-- Prompt style
theme.prompt={}  
theme.prompt["fg_cursor"]             = "#BFBFBF"
theme.prompt["bg_cursor"]             = "#0F276600"
theme.prompt["ul_cursor"]             = "single"
theme.prompt["font"]                  = "Roboto 8"
theme.prompt["cmd"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>CMD:</span> "
theme.prompt["run"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>RUN:</span> "
theme.prompt["lua"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>LUA:</span> "

-- Tasklist widget
theme.task={}
theme.task["font"]                    = "Liberation sans 9"
theme.task["fg_normal"]               = "#155898"
theme.task["bg_normal"]               = pattern(res.."/background/tasklist_normal.png")
theme.task["fg_focus"]                = "#4D4D4D"
theme.task["bg_focus"]                = pattern(res.."/background/tasklist_focus.png")
theme.task["fg_urgent"]               = "#1692D0"
theme.task["bg_urgent"]               = pattern(res.."/background/tasklist_urgent.png")
theme.task["fg_minimize"]             = "#1692D0"
theme.task["bg_minimize"]             = pattern(res.."/background/tasklist_minimize.png")
theme.task["sticky"]                  = "▪"
theme.task["ontop"]                   = '⌃'
theme.task["floating"]                = '✈'
theme.task["maximized_horizontal"]    = '⬌'
theme.task["maximized_vertical"]      = '⬍'
theme.tasklist_disable_icon           = false
theme.tasklist_plain_task_name        = true

-- Titlebar
theme.titlebar={}
theme.titlebar["all"]                 = false
theme.titlebar["float"]               = true
theme.titlebar["dialog"]              = true
theme.titlebar["status"]              = true
theme.titlebar["size"]                = 13
theme.titlebar["valign"]              = "center"
theme.titlebar["position"]            = "top"
theme.titlebar["font"]                = "Liberation Mono 8"
theme.titlebar["bg_focus"]            = pattern(res.."/background/titlebar_focus.png")
theme.titlebar["fg"]                  = "#7F7F7F"
theme.titlebar["bg"]                  = pattern(res.."/background/titlebar.png")

-- Naughty settings
naughty.config.defaults.timeout       = 5
naughty.config.defaults.position      = "top_right" 
naughty.config.defaults.margin        = 1
naughty.config.defaults.gap           = 10
naughty.config.defaults.ontop         = true
naughty.config.defaults.icon_size     = dpi(24)
naughty.config.defaults.font          = "Roboto Medium 9"
naughty.config.defaults.fg            = "#7F7F7F"
naughty.config.defaults.bg            = pattern(res.."/background/notify.png")
naughty.config.defaults.border_color  = "#4D4D4D"
naughty.config.defaults.border_width  = dpi(1)
naughty.config.defaults.hover_timeout = 1




return theme