local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("unity.common")
local places    = require("unity.places")
local iconsvol    = require("unity.mixer_places.iconsvol")

local module = {}

local mixer = os.execute("mixer vol")

module.OPEN = "mixer vol"
module.PATHS =  {  

    { "",                 "mixer vol  0"  ,      "audio-volume-muted.png", },
    { "*",                "mixer vol  10"  ,     " ",                      },
    { "** ",              "mixer vol  20"  ,     " ",                      },
    { "*** ",             "mixer vol  30"  ,     " ",                      },
    { "**** ",            "mixer vol  40"  ,     " ",                      },
    { "***** ",           "mixer vol  50"  ,     " ",                      },
    { "****** ",          "mixer vol  60"  ,     " ",                      },
    { "******* ",         "mixer vol  70"  ,     " ",                      },
    { "******** ",        "mixer vol  80"  ,     " ",                      },
    { "********* ",       "mixer vol  90"  ,     " ",                      },
    { "**********",       "mixer vol  100" ,     " ",                      }
    
}

module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.context({
            filer = false, enable_keyboard = true, direction = "right", x = screen[1].geometry.width - 200,
            y = screen[1].geometry.height - beautiful.wibox.width - (#module.PATHS*beautiful.menu_height) - 28,
        })
        local tags = awful.tag.gettags(1)
        for _,t in ipairs(module.PATHS) do
            module.menu:add_item({
                tooltip = t[2],
                button1 = function()
                    awful.util.spawn(module.OPEN.." "..t[2])
                    common.hide_menu(module.menu)
                end,
                text=t[1], icon=beautiful.path.."/mixer/"..t[3] 
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
    local layout = wibox.layout.flex.horizontal()
    layout:add(iconsvol())
    layout:add(places())
   
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
