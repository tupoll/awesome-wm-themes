local gears   = require("gears")
local awful   = require("awful")
local naughty = require("naughty")
local cairo   = require("lgi").cairo

-- Create cairo pattern from png file
local function pattern(image)
    local pat = cairo.Pattern.create_for_surface(cairo.ImageSurface.create_from_png(image))
    cairo.Pattern.set_extend(pat,cairo.Extend.REPEAT)
    return pat
end

local theme = {}

theme.path                            = awful.util.getdir("config").."/themes/level/level"
theme.menu_submenu_icon               = theme.path.."/submenu.png"
theme.awesome_icon                    = theme.path.."/logos/awesome.png"
theme.dist_icon                       = theme.path.."/logos/free_bsd.png"
theme.widget_bg                                 = theme.path .. "/icons/widget_bg.png"

theme.taglist_bg_focus                          = theme.path .. "/tags/bg_focus.png"
theme.rx_icon                                   = theme.path .. "/icons/rx0.png"
theme.tx_icon                                    = theme.path .. "/icons/tx0.png"
theme.vol_mute                                  = theme.path .. "/icons/vol_mute.png"
reboot                                          = theme.path .. "/icons/reboot.png"
    shutdown                                    = theme.path .. "/icons/shutdown.png"
    logout                                      = theme.path .. "/icons/logout.png"
    accept                                      = theme.path .. "/icons/ok.png"
    cancel                                      = theme.path .. "/icons/cancel.png"
    lock                                        = theme.path .. "/icons/lock.png"                                  
theme.wallpaper                       = theme.path.."/bsd_blue1.png"
theme.unknown                         = theme.path.."/logos/unknown.svg"
theme.bg_systray                      = "#00184800"
theme.menu_height                     = 19
theme.menu_timeout                    = 10
theme.default_height                  = 16
theme.icon_theme                      = nil

-- Main wibox settings
theme.wibox={}
theme.wibox.position                  = "right"
theme.wibox.width                     = 58
theme.wibox.bg                        = pattern(theme.path.."/background/wibox.png")
theme.wibox.fg                        = "#4D4D4D"


-- Taglist widget
theme.unitybar={}
theme.unitybar.width                     = 58
theme.unitybar.bg_urgent                 = "#ff000088"
theme.unitybar.img_focused               = theme.path.."/tags/bg_focus.png"


-- Tasklist widget
theme.task={}
theme.task["font"]                    = "Liberation sans 9"
theme.task["fg_normal"]               = "#155898"
theme.task["bg_normal"]               = pattern(theme.path.."/background/tasklist_normal.png")
theme.task["fg_focus"]                = "#4D4D4D"
theme.task["bg_focus"]                = pattern(theme.path.."/background/tasklist_focus.png")
theme.task["fg_urgent"]               = "#1692D0"
theme.task["bg_urgent"]               = pattern(theme.path.."/background/tasklist_urgent.png")
theme.task["fg_minimize"]             = "#1692D0"
theme.task["bg_minimize"]             = pattern(theme.path.."/background/tasklist_minimize.png")
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
theme.titlebar["bg_focus"]            = pattern(theme.path.."/background/titlebar_focus.png")
theme.titlebar["fg"]                  = "#7F7F7F"
theme.titlebar["bg"]                  = pattern(theme.path.."/background/titlebar.png")

-- Tray
theme.tray={}
theme.tray.position                   = "bottom"
theme.tray.height                     = 10
theme.tray.bg                         = pattern(theme.path.."/background/tasklist.png")
theme.tray.fg                         = "#4D4D4D"

-- Prompt style
theme.prompt={}  
theme.prompt["fg_cursor"]             = "#BFBFBF"
theme.prompt["bg_cursor"]             = "#0F276600"
theme.prompt["ul_cursor"]             = "single"
theme.prompt["font"]                  = "Goha-Tibeb Zemen 10"
theme.prompt["cmd"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>CMD:</span> "
theme.prompt["run"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>RUN:</span> "
theme.prompt["lua"]                   = "<span foreground='#1692D0' font='Sci Fied 8'>LUA:</span> "

-- Text widget
theme.widget={}
theme.widget["font"]                  = "Goha-Tibeb Zemen 8"
theme.widget["fg"]                    = "#7F7F7F"
theme.widget["bg"]                    = pattern(theme.path.."/background/wibox.png")
theme.widget["align"]                 = "center"
theme.widget["valign"]                = "center"

-- Radical menus
theme.menu_border_width               = 1
theme.menu_border_color               = "#4D4D4D"
theme.menu_fg_normal                  = "#7F7F7F"
theme.menu_bg_normal                  = pattern(theme.path.."/background/menu.png")
theme.menu_bg_focus                   = pattern(theme.path.."/background/radical_focus.png")
theme.menu_bg_header                  = pattern(theme.path.."/background/radical_header.png")
theme.menu_bg_highlight               = pattern(theme.path.."/background/radical_highlight.png")
theme.menu_bg_alternate               = "#98732F"
theme.tooltip_bg                      = pattern(theme.path.."/background/tooltip.png")
theme.tooltip_fg                      = "#7F7F7F"

-- Naughty settings
naughty.config.defaults.timeout       = 5
naughty.config.defaults.position      = "top_right" 
naughty.config.defaults.margin        = 1
naughty.config.defaults.gap           = 10
naughty.config.defaults.ontop         = true
naughty.config.defaults.icon_size     = 16
naughty.config.defaults.font          = "Liberation Mono 10"
naughty.config.defaults.fg            = "#7F7F7F"
naughty.config.defaults.bg            = pattern(theme.path.."/background/wibox.png")
naughty.config.defaults.border_color  = "#4D4D4D"
naughty.config.defaults.border_width  = 1
naughty.config.defaults.hover_timeout = 1

-- Awesome
theme.border_width                    = 1
theme.border_color                    = "#1577D3"
theme.border_normal                   = "#000000"
theme.border_focus                    = "#00346D"
theme.border_marked                   = "#FFF200"
theme.border_tagged                   = "#8B6914"
theme.font                            = "Terminus Bold 10"
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

-- Titlebar icons
theme.titlebar_close_button_normal              = theme.path.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.path.."/titlebar/close_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.path.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.path.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.path.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_active        = theme.path.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.path.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.path.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.path.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.path.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.path.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.path.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.path.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.path.."/titlebar/floating_focus_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.path.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.path.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.path.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.path.."/titlebar/maximized_normal_inactive.png"

-- Set wallpaper 
gears.wallpaper.maximized(theme.wallpaper, 1, true)

local function rgb(red, green, blue)
  if type(red) == "number" or type(green) == "number" or type(blue) == "number" then
    return "#"..string.format("%02x",red)..string.format("%02x",green)..string.format("%02x",blue)
  else    
    return nil
  end
end

local function rgba(red, green, blue, alpha) 
  if type(red) == "number" or type(green) == "number" or type(blue) == "number" or type(alpha) == "number" then
    return "#"..string.format("%02x",red)..string.format("%02x",green)..string.format("%02x",blue)..string.format("%02x",alpha * 255)
  else
    return nil
  end
end

return theme
