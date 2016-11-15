local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common")

local module = {}

local HOME = os.getenv("HOME")

module.OPEN = "pcmanfm"
module.PATHS = {
    { "Home",        HOME,                 "home.svg",        "n" },
    { "Cloud",       HOME.."/Cloud",       "remote.svg",      "r" },
    { "Development", HOME.."/Development", "development.svg", "d" },
    { "Workspace",   HOME.."/Workspace",   "workspace.svg",   "t" },
    { "Документы",   HOME.."/Documents",   "documents.svg",   "h" },
    { "Загрузки",   HOME.."/Загрузки",   "downloads.svg",   "f" },
    { "Музыка",       HOME.."/Музыка",       "music.svg",       "m" },
    { "Изображения",    HOME.."/Изображения",    "pictures.svg",    "p" },
    { "Видео",      HOME.."/Видео",      "videos.svg",      "v" },
    { "www",         HOME.."/public_html", "public_html.svg", "w" },
    { "Security",    "/opt/Security",      "security.svg",    "s" }
}

module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = screen[1].geometry.width - 220,
            y = screen[1].geometry.height - beautiful.wibox.height - (#module.PATHS*beautiful.menu_height) - 28,
        })
        local tags = awful.tag.gettags(1)
        for _,t in ipairs(module.PATHS) do
            module.menu:add_item({
                tooltip = t[2],
                button1 = function()
                    awful.util.spawn(module.OPEN.." "..t[2])
                    awful.tag.viewonly(tags[4])
                    common.hide_menu(module.menu)
                end,
                text=t[1], icon=beautiful.path.."/places/"..t[3], underlay = string.upper(t[4])
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
    layout:add(common.imagebox({ icon=beautiful.path.."/widgets/places.svg" }))
    layout:add(common.textbox({ text="PLACES", width=60, b1=module.main }))
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
