local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local radical   = require("radical")
local common    = require("compact.common")

local module = {}

-- Main menu table
module.mapp = {}
module.mapp["Интернет"] = {
    icon = "network.svg",
    items = {
        { name="Qupzilla",                 command="qupzilla",              icon="qupzilla.png"     },
        { name="Firefox",                  command="firefox",              icon="firefox.svg"     },
        { name="Торрент",                  command="qbittorrent",           icon="qbittorrent.png"   },
        { name="Vimb",                     command="vimb",               icon="zenmap.png"      }       
    }
}
module.mapp["Программы"] = {
    icon = "development.svg",
    items = {
        { name="About Xfce",              command="xfce4-about",        icon="xfce4-logo.svg"      },
        { name="Archive Manager",         command="xarchiver",          icon="accessories-archiver.svg"        },
        { name="Thunar",                  command="thunar",           icon="file-manager.svg"      },
        { name="Gxmessage",               command="gxmessage",          icon="dbeaver.png"     },
        { name="Pcmanfm",                 command="pcmanfm",           icon="file-manager.svg"      },
        { name="Terminal Emulator",       command="exo-open --launch TerminalEmulator",        icon="regex.png"       }
    }
}

module.mapp["Другие"] = {
    icon = "reader.svg",
    items = {
        { name="PolicyKit Authentication Agent",                 command="/usr/local/lib/polkit-gnome/polkit-gnome-authentication-agent-1",             icon="quiterss.png"    }
    }
}
module.mapp["Графика"] = {
    icon = "graphics.svg",
    items = {
        { name="Снимок",                   command="gscrot",          icon="digikam.png"     },
        { name="Ristretto",                command="ristretto ",         icon="xnview.png"    },
        { name="Gimp",                     command="gimp",             icon="gimp.png"        }
    }
}
module.mapp["Multimedia"] = {
    icon = "multimedia.svg",
    items = {
        { name="Burn Image (xfburn)",      command="xfburn -i %f",          icon="audio-cd-duplicate.svg"    },
        { name="MPlayer Media Player",     command="mplayer %F",            icon="avidemux.svg"     },
        { name="Qt V4L2 test Utility",     command="qv4l2",                 icon="ffmpeg.png"      }
    }
}
module.mapp["Office"] = {
    icon = "office.svg",
    items = {
        { name="OpenOffice",                command="openoffice4",             icon="yEd.png"         },
        { name="OpenOffice 4.1.0 Writer",   command="openoffice4 -writer",     icon="ebook.png"       },
        { name="OpenOffice 4.1.0 Base",     command="openoffice4 -base",       icon="thunderbird.png" }
    }
}
module.mapp["Система"] = {
    icon = "system.svg",
    items = {
        { name="urxvt",                   command="urxvt",                     icon="terminal.svg" },
        { name="urxvt (client)",          command="urxvtc",                    icon="system.png"     },
        { name="urxvt (tabbed)",          command="urxvt-tabbed",              icon="apol.png"        },
        { name="UXTerm",                  command="urxvt-tabbed",              icon="seaudit.png"     },
        { name="XTerm",                   command="xterm",                     icon="selinux.png"     }
    }
}
module.mapp["Программирование"] = {
    icon = "awesome.svg",
    items = {
        { name="CMake",                  command="cmake-gui %f",               icon="terminal.svg"    },
        { name="Geany",                  command="geany %F",                   icon="geany.svg" },
        { name="OpenJDK Policy Tool",    command="/usr/local/bin/policytool",           icon="virustotal.png"  },
        { name="Qt4 Assistant",          command="assistant-qt4",         icon="comodo.png"      },
        { name="Qt4 Designer",           command="designer-qt4",               icon="clamtk.png"      },
        { name="Qt4 Linguist",           command="linguist-qt4",             icon="krusader.png"    },
        { name="Qt4 QDbusViewer",        command="qdbusviewer-qt4",                 icon="kate.png"        }
    }
}

module.mapp["Настройки"] = {
    icon = "miscellaneous.svg",
    items = {
        { name="Adobe Flash Player",                 command="flash-player-properties",            icon="terminal.svg"    },
        { name="Customize Look and Feel",            command="lxappearance",                       icon="desktop-effects.svg" },
        { name="NVIDIA X Server Settings",           command="/usr/bin/nvidia-settings",           icon="nvidia.png"  },
        { name="Preferred Applications",             command="libfm-pref-apps",                    icon="comodo.png"      },
        { name="Preferred Applications",             command="exo-preferred-applications",         icon="clamtk.png"      },
        { name="Preferred Applications",             command="libsmfm-pref-apps",                  icon="krusader.png"    },
        { name="Privilege granting",                 command="gksu-properties",                    icon="kate.png"        },
        { name="Qt4 Config",                         command="qtconfig-qt4",                       icon="copyq.png"       }
    }
}



--passed = applicationsmenu[1]
--function applicationsmenu() return passed end
-- Quick menu table.
module.qapp = {}
module.qapp["Terminal"]     = { command="urxvt",       key="t", icon="terminal.svg",         tag=1 }
module.qapp["File Manager"] = { command="pcmanfm",      key="f", icon="file-manager.svg",     tag=1 }
module.qapp["Web browser"]  = { command="firefox",    key="w", icon="browser.svg",          tag=3 }
module.qapp["Editor"]       = { command="geany",       key="e", icon="editor.svg",           tag=2 }
module.qapp["MOC"]          = { command="xterm -e mocp",  key="m", icon="thunderbird.svg",             tag=6 }
module.qapp["Торент"]       = { command="qbittorrent", key="q", icon="qbittorrent.png",      tag=4 }
module.qapp["Gscrot"]       = { command="gscrot",      key="s", icon="record.png",                 }
module.qapp["Vimb"]         = { command="vimb",        key="v", icon="irc.svg",              tag=3 }
module.qapp["Изображения"]  = { command="ristretto",   key="k", icon="applications-graphics.svg",       tag=5 }
module.qapp["Gimp"]         = { command="gimp",        key="g", icon="proc.svg",             tag=5 }

-- Main menu builder
module.menu_visible = false
function module.main_app()
    if module.menu_visible and module.menu_app then
        module.menu_app:hide()
        module.menu_visible = false
        return
    elseif not module.menu_visible and not module.menu_app then
        local menu_items = {}
        local function submenu(t)
            local submenus = {}
            for i,_ in pairs(t) do
                table.insert(submenus,{t[i].name, t[i].command, beautiful.path.."/launcher/app/"..t[i].icon or beautiful.unknown})
            end
            return submenus
        end
        for k,v in pairs(module.mapp) do
            table.insert(menu_items, {k, submenu(v.items), beautiful.path.."/launcher/"..v.icon or beautiful.unknown})
        end
        module.menu_app = awful.menu.new({items=menu_items,theme={height=18,width=140}})
    end
    module.menu_app:show()
    module.menu_visible = true
end

-- Action
local function run(data)
    local tags = awful.tag.gettags(1)
    awful.util.spawn(data.command)
    if tags[data.tag] then awful.tag.viewonly(tags[data.tag]) end
    common.hide_menu(module.menu_qapp)common.hide_menu(module.menu_qapp)
end

-- Quick menu builder
module.menu_qapp = false
function module.main_qapp()
    if not module.menu_qapp then
        module.menu_qapp = radical.context({
            filer = false, enable_keyboard = true, direction = "bottom", x = 80,
            y = screen[1].geometry.height - beautiful.wibox.height - ((#awful.util.table.keys(module.qapp))*beautiful.menu_height) - 28
        })
        for i,v in pairs(module.qapp) do
            module.menu_qapp:add_key_hook({}, string.lower(v.key), "press", function() run(v) end)
            --module.menu_qapp:add_key_binding({}, string.lower(v.key), function() dbg.dump(v.key) end)
            module.menu_qapp:add_item({
                button1 = function() run(v) end,
                text = i or "N/A", underlay = string.upper(v.key),
                icon = beautiful.path.."/launcher/quick/"..v.icon or beautiful.unknown
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
    layout:add(common.imagebox({icon=beautiful.dist_icon, b1=module.main_qapp, b3=module.main_app }))    
    layout:add(common.textbox({text="MENU", width=50, b1=module.main_qapp, b3=module.main_app }))
    return layout
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })
