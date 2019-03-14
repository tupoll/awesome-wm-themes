--@author cedlemo
language = string.gsub(os.getenv("LANG"), ".utf8", "")


local os = os
local string = string
local awful = require("awful")
local textbox = require("wibox.widget.textbox")
local text_box = require("blingbling.text_box")
local days_of_week_in_kanji={ 
"воскресенье", "понедельник","вторник","среда","четверг","пятница","суббота"
}
local days_of_week_in_kana={
"Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница",
"В субботу"
}

local kanji_numbers={
"1","2","3","4","5","6","7","8",
"9","10","11","12","13",
"14", "15","16","17",
"18","19","20","21","22",
"23","24", "25","26",
"27","28","29","30",
"31"
}
local kanas_numbers={
"Чаша", "Panax", "хорошо", "пять", "смерть", "г-н", "в", "один", "во всем", "оговорка"
}
local days_of_month_in_kanas={  
"1","2","3","4","5","6","7","8",
"9","10","11","12","13",
"14", "15","16","17",
"18","19","20","21","22",
"23","24", "25","26",
"27","28","29","30",
"31"
}
---A clock module 
--@module blingbling.clock

local function get_day_of_month_in_kanji(n)
	--if n<=10 then
		--return kanji_numbers[n] .. "день"
	--elseif n<20 then
		--return kanji_numbers[10]..(kanji_numbers[n-10] or "") .. "день"
	--elseif n<30 then
		--return kanji_numbers[2]..kanji_numbers[10]..(kanji_numbers[n-20] or "").. "день"
	if n<=31 then
		return kanji_numbers[n] .. "день"   --return kanji_numbers[n]..kanji_numbers[n]..(kanji_numbers[n-30] or "").. "день"
	end
end
local function get_month_in_kanji(n)
	if n<=10 then
		return kanji_numbers[n].."месяц"
	elseif n<=12 then
		return kanji_numbers[12]..(kanji_numbers[n-12] or "").."месяц"
	end
end
romajis_days_of_month={}
local function get_current_day_of_week_in_kanji()
	return days_of_week_in_kanji[tonumber(os.date("%w") + 1)]
end
local function get_current_day_of_week_in_kanas()
	return days_of_week_in_kana[tonumber(os.date("%w") + 1)]
end
local function get_current_day_of_month_in_kanji()
	return get_day_of_month_in_kanji(tonumber(os.date("%d")))
end
local function get_current_day_of_month_in_kanas()
  return days_of_month_in_kanas[tonumber(os.date("%d"))]
end
local function get_current_month_in_kanji()
	return get_month_in_kanji(tonumber(os.date("%m")))
end
local function get_current_hour()
	return os.date("%H")
end
local function get_current_minutes()
	return os.date("%M")
end
local function get_current_time_in_japanese( str)
	--if type(string) ~= "string" then
	--	return nil
	--end
	local result = str or "%m、%d、%w、%H%M" 
	result = string.gsub(result,"%%w",get_current_day_of_week_in_kanji())
	result = string.gsub(result,"%%d",get_current_day_of_month_in_kanji())
	result = string.gsub(result,"%%m",get_current_month_in_kanji())
	result = os.date(result)
	return result
end

local function japanese_clock(str, args)
	local clock = text_box(args)
	
	clock:set_text(get_current_time_in_japanese( str ))
	clocktimer = timer({ timeout = 1 })
	clocktimer:connect_signal("timeout", function() clock:set_text(get_current_time_in_japanese( str )) end)
	clocktimer:start()
	--clock_tooltip= awful.tooltip({
	--	objects = { clock },
	--	timer_function= function()
	--		return os.date("%B, %d, %A, %H:%M")
	--	end,
	--	})
	return clock
end
---A clock that displays the date and the time in kanjis. This clock have a popup that shows the current date in your langage.
--@usage myclock = blingbling.japanese_clock() --then just add it in your wibox like a classical widget
--@name japanese_clock
--@class function
--@return a clock widget

return {
	japanese = japanese_clock,
  get_current_time_in_japanese = get_current_time_in_japanese,
  get_current_day_of_week_in_kanji = get_current_day_of_week_in_kanji,
  get_current_day_of_month_in_kanji = get_current_day_of_month_in_kanji,
  get_current_month_in_kanji = get_current_month_in_kanji,
  get_current_day_of_month_in_kanas = get_current_day_of_month_in_kanas,
  get_current_day_of_week_in_kanas = get_current_day_of_week_in_kanas
}
