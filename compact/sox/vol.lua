local beautiful = require("beautiful")
local radical   = require("radical")
local awful     = require("awful")
local common    = require("compact.common.helpers1")
local HOME = os.getenv("HOME")
local res = ".config/awesome/themes/pattern/play/"

local module = {}

module.OPEN = "lua52"
module.PATHS =  {  

    { "VOLUME SOX",                            " "  ,     " ",                           },
    { "*",                " .config/awesome/compact/sox/drivers/vol/10.lua"  ,     "10", },
    { "** ",              " .config/awesome/compact/sox/drivers/vol/20.lua"  ,     "20", },
    { "*** ",             " .config/awesome/compact/sox/drivers/vol/30.lua"  ,     "30", },
    { "**** ",            " .config/awesome/compact/sox/drivers/vol/40.lua"  ,     "40", },
    { "***** ",           " .config/awesome/compact/sox/drivers/vol/50.lua"  ,     "50", },
    { "****** ",          " .config/awesome/compact/sox/drivers/vol/60.lua"  ,     "60", },
    { "******* ",         " .config/awesome/compact/sox/drivers/vol/70.lua"  ,     "70", },
    { "******** ",        " .config/awesome/compact/sox/drivers/vol/80.lua"  ,     "80", },
    { "********* ",       " .config/awesome/compact/sox/drivers/vol/90.lua"  ,     "90", },
    { "********** ",      " .config/awesome/compact/sox/drivers/vol/100.lua" ,     "100"  }
    
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
                tooltip = t[3],
                button1 = function()
                    awful.spawn(module.OPEN.." "..t[2])
               --     awful.tag.viewonly(tags)
                    common.hide_menu(module.menu)
                end,
                text=t[1], icon=res .. "/play/"  ..t[3] 
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
