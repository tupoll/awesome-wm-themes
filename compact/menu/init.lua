local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common.helpers1")
local box_bl    = require("compact.menu.box_bl")
local freedesktop   = require("compact.menu.freedesktop")
local screen = require("awful.screen")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/launcher/quick/"
local common    = require("compact.common.helpers1")

local module = {}

-- Main menu table

local terminal     = "urxvtc" or "xterm"
-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
--    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
  
    
    before = {
        { "Awesome", myawesomemenu, beautiful.distr_icon},
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

language = string.gsub(os.getenv("LANG"), ".utf8", "")
os.setlocale(os.getenv("LANG"))

-- Quick menu table.
module.qapp = {}
module.qapp["Terminal             T"]     = { command="urxvt",     key="t", icon="terminal.svg",         tag=1 }
module.qapp["File Manager         F"] = { command="thunar",        key="f", icon="file-manager.svg",     tag=1 }
module.qapp["Web browser          W"]  = { command="brave-bin ",        key="w", icon="browser.svg",          tag=3 }
module.qapp["Editor               E"]       = { command="geany",          key="e", icon="editor.svg",           tag=2 }
module.qapp["MOC                  M"]          = { command="xterm -e mocp",  key="m", icon="thunderbird.svg",             tag=6 }
module.qapp["Торент               D"]       = { command="deluge",         key="d", icon="deluge.svg",                tag=4 }
module.qapp["Gscrot               S"]       = { command="zsh -c gscrot",         key="s", icon="record.png",                 }
module.qapp["Blueaudio            K"]         = { command="sudo /usr/local/bin/blueaudio" ,           key="k", icon="bluezaudio.png",              }
module.qapp["Изображения          R"]  = { command="gthumb",      key="r", icon="applications-graphics.svg",       tag=5 }
module.qapp["Gimp                 G"]         = { command="gimp",           key="g", icon="proc.svg",             tag=5 }
module.qapp["Chromium             C"]     = { command="chrome",         key="c", icon="google-chrome2.png",   tag=4 }
module.qapp["Sublime              V"]     = { command="subl",         key="v", icon="sublime-text.png",   tag=4 }

-- Action
local function run(data)
    local tags = root.tags(1)
    awful.spawn(data.command)
    --if tags[data.tag] then awful.tag.find_by_name(tags[data.tag]) end
    if tags[data.tag] then awful.tag.find_by_name((function(t) t:view_only() end) (tags[data.tag]))end
    common.hide_menu(module.menu_qapp)common.hide_menu(module.menu_qapp)
end
-- Quick menu builder
module.menu_qapp = false
function module.main_qapp()
    if not module.menu_qapp then
        module.menu_qapp = box_bl({
        style      = grouped_3d     ,
        item_style = radical.item.style.line_3d ,
        item_height = 18,--48,
        width = 170,
        layout = radical.layout.vertical, --horizontal,
        border_width = 2,
        border_color = "#88aa00",
        spacing  = 4,     
        enable_keyboard = true,
        item_layout = radical.layout.centerred
        })
        for i,v in pairs(module.qapp) do
            module.menu_qapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
            --module.menu_qapp:add_key_binding({}, string.lower(v.key), function() dbg.dump(v.key) end)
            module.menu_qapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = res .. v.icon 
            })
        end
        common.reg_menu(module.menu_qapp)
    elseif module.menu_qapp.visible then
        common.hide_menu(module.menu_qapp)
    else
        common.show_menu(module.menu_qapp)
    end
end

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()   
    local widget_img,img = common.imagebox({icon=beautiful.distr_icon, b1=module.main_qapp, b3=function () awful.util.mymainmenu:toggle() end })
--    local widget_txt,text = common.textbox({text="", width=10, b1=module.main_qapp, b3=function () awful.util.mymainmenu:toggle() end  })
    layout:add(widget_img)
--    layout:add(widget_txt)
   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
