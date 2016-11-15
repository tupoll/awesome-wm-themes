--skb.lua by tupoll
local wibox = require('wibox')
local naughty = require('naughty')
--local utility = require('utility')
local awful = require("awful")

local devnull = ">/dev/null"

local xset = {}


function xset.new()

   local w = wibox.widget.textbox()
   w:set_align("center")
   w:set_valign("center")
   w.fit = function() return 62,38 end 
   w:set_text(awful.util.pread(
   " skb" --нихера не буду пояснять 
)) 

  xsettimer = timer(
   { timeout = 1 ,hover_timeout = 0.5} -- Update every 15 minutes.
)
  xsettimer:connect_signal(
   "timeout", function()
      w:set_text(awful.util.pread(
         "skb" 
      ))end)

 xsettimer:start() -- Start the timer
w:connect_signal(
   "mouse::enter", function()
      xset = naughty.notify(
         {title="КЛАВИАТУРА",text=awful.util.pread("skb") ,
          position      =  "bottom_right",
          width = 85
  })  
end) 


w:connect_signal(
   "mouse::leave", function()
      naughty.destroy(xset)
end)

return w

end

return setmetatable(xset, { __call = function(_, ...) return xset.new(...) end})
