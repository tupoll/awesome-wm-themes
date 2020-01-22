local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local placement = require( "awful.placement" )
local box_bl    = require("compact.places.box_bl")

local module = {}

local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/places/"

module.OPEN = "thunar"
module.PATHS = {
    { "Home",        HOME,                 "home.png",      "h" },
    { "usb",       HOME.."/usb",       "usb.png",       "u" },
    { "photo", HOME.."/Изображения/фото", "camera-photo.png", "c" },   
    { "Документы",   HOME.."/Документы",   "documents.png",   "i" },
    { "Загрузки",   HOME.."/Загрузки",   "download.png",   "d" },
    { "Музыка",       HOME.."/Музыка",       "music.png",       "m" },
    { "Изображения",    HOME.."/Изображения",    "pictures.png",    "p" },
    { "Видео",      HOME.."/Видео",      "video.png",      "v" },
    { "screnshoots",      HOME.."/Изображения/screenshots",      "screenshots.png",      "s" }
}

module.menu = false
function module.main()
    if not module.menu then
        module.menu = box_bl({
        style      = grouped_3d     ,
        item_style = radical.item.style.line_3d ,
        item_height = 18,--48,
        width = 160,
        placement = placement.bottom_left
        
        })
        local tags = root.tags()
        for _,t in ipairs(module.PATHS) do
            module.menu:add_item({
                tooltip = t[2],
                button1 = function()
                    awful.spawn(module.OPEN.." "..t[2])               
                    common.hide_menu(module.menu)
                end,
                text=t[1], icon=res .. t[3], underlay = string.upper(t[4])
            })
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
--    layout:add(common.textbox({text="", width=10 }))
    local widget_img,img = common.imagebox({ icon=res .. "/places.svg" })
    local widget_txt,text = common.textbox({ text="PLACES", width=60, b1=module.main })
    layout:add(widget_img)
    layout:add(widget_txt)
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
