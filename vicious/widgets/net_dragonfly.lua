-- {{{ Grab environment
local tonumber = tonumber
local os = { time = os.time }
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
local io = { popen = io.popen }
local string = { match = string.match }
-- }}}


-- Net: provides state and usage statistics of all network interfaces
-- vicious.widgets.net
local net_dragonfly = {}


-- Initialize function tables
local nets = {}
-- Variable definitions
local unit = { ["b"] = 1, ["kb"] = 1024,
    ["mb"] = 1024^2, ["gb"] = 1024^3
}

-- {{{ Net widget type
local function worker(format, warg)
    if not warg then return end

    local args = {}
    local buffer = nil
    local f = awful.spawn.easy_async("zsh", "-c", "netstat -n -b -I"  .. helpers.shellquote(warg))
    local now = os.time()
    
    for line in f:lines() do
        if not (line:find("<Link") or line:find("Name")  or line:find("fe")) then -- пропустить вводящие в заблуждение строки
            local split = { line:match(("([^%s]*)%s*"):rep(11)) }

            if buffer == nil then
                buffer = { tonumber(split[7]), tonumber(split[10]) } -- -recv (поле 8) и отправить (поле 11)
            else
                buffer = { buffer[1] + tonumber(split[7]), buffer[2] + tonumber(split[10]) }
            end
        end
    end

    f:close()

    if buffer == nil then
        args["{carrier}"] = 0
        helpers.uformat(args, "in", 0, unit)
        helpers.uformat(args, "out", 0, unit)
        helpers.uformat(args, "down", 0, unit)
        helpers.uformat(args, "up",   0, unit)
    else
        args["{carrier}"] = 1
        helpers.uformat(args, "in", buffer[1], unit)
        helpers.uformat(args, "out", buffer[2], unit)

        if next(nets) == nil then
            helpers.uformat(args, "down", 0, unit)
            helpers.uformat(args, "up",   0, unit)
        else
            local interval = now - nets["time"]
            if interval <= 0 then interval = 1 end

            local down = (buffer[1] - nets[1]) / interval
            local up   = (buffer[2] - nets[2]) / interval

            helpers.uformat(args, "down", down, unit)
            helpers.uformat(args, "up",   up,   unit)
        end
        
        nets["time"] = now

        -- Store totals
        nets[1] = buffer[1]
        nets[2] = buffer[2]
    end

    return args

end
-- }}}

return setmetatable(net_dragonfly, { __call = function(_, ...) return worker(...) end })
