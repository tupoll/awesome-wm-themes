local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/mixer/"

local module = {}

local mixer = os.execute("mixer treble")

module.OPEN = "mixer treble"
module.PATHS =  {  

    { "treble",                 "mixer treble  0"  ,      "stop.png", },
    { "*",                "mixer treble  10"  ,     " ",                      },
    { "** ",              "mixer treble  20"  ,     " ",                      },
    { "*** ",             "mixer treble  30"  ,     " ",                      },
    { "**** ",            "mixer treble  40"  ,     " ",                      },
    { "***** ",           "mixer treble  50"  ,     " ",                      },
    { "****** ",          "mixer treble  60"  ,     " ",                      },
    { "******* ",         "mixer treble  70"  ,     " ",                      },
    { "******** ",        "mixer treble  80"  ,     " ",                      },
    { "********* ",       "mixer treble  90"  ,     " ",                      },
    { "**********",       "mixer treble  100" ,     " ",                      }
    
}

module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.box({
            filer = false, enable_keyboard = true, direction = "bottom", x = screen[1].geometry.width - 715,
            y = screen[1].geometry.height - beautiful.wibox.height - (#module.PATHS*beautiful.menu_height) - 28,
        })
        local tags = awful.tag.gettags(1)
        for _,t in ipairs(module.PATHS) do
            module.menu:add_item({
                tooltip = t[2],
                button1 = function()
                    awful.util.spawn(module.OPEN.." "..t[2])
               --     awful.tag.viewonly(tags)
                    common.hide_menu(module.menu)
                end,
                text=t[1], icon=res .."/mixer/" ..t[3] 
            })
        end
        common.reg_menu(module.menu)
    elseif module.menu.visible then
        common.hide_menu(module.menu)
    else
        common.show_menu(module.menu)
    end
end


--[[

-- Return widgets layout
local function new()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(common.arrow(3))
   -- layout:add(common.imagebox({ icon=beautiful.path.."/mixer/gnome-volume-control.png" }))
    layout:add(common.textbox({ text="treble", width=60, b1=module.main }))
    layout:add(volume())
    return layout
end
--]]
return setmetatable(module, { __call = function(_, ...) return new(...) end })
