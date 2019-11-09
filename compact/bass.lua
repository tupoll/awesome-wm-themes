local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")

local module = {}

local mixer = os.execute("mixer bass")

module.OPEN = "mixer bass"
module.PATHS =  {  

    { "bass",                 "mixer bass  0"  ,      "stop.png", },
    { "*",                "mixer bass  10"  ,     " ",                      },
    { "** ",              "mixer bass  20"  ,     " ",                      },
    { "*** ",             "mixer bass  30"  ,     " ",                      },
    { "**** ",            "mixer bass  40"  ,     " ",                      },
    { "***** ",           "mixer bass  50"  ,     " ",                      },
    { "****** ",          "mixer bass  60"  ,     " ",                      },
    { "******* ",         "mixer bass  70"  ,     " ",                      },
    { "******** ",        "mixer bass  80"  ,     " ",                      },
    { "********* ",       "mixer bass  90"  ,     " ",                      },
    { "********** ",      "mixer bass  100" ,     " ",                      }
    
}

module.menu = false
function module.main()
    if not module.menu then
        module.menu = radical.box({
            filer = false, enable_keyboard = true, direction = "bottom", x = screen[1].geometry.width - 715,
            y = screen[1].geometry.height - beautiful.wibox.height - (#module.PATHS*beautiful.menu_height) - 28,
        })
        local tags = root.tags(1)
        for _,t in ipairs(module.PATHS) do
            module.menu:add_item({
                tooltip = t[2],
                button1 = function(t)
                    awful.spawn(module.OPEN.." "..t[2])
                    tag:view_only()
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

return setmetatable(module, { __call = function(_, ...) return new(...) end })
