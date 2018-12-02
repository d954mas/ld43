local COMMON = require "libs.common"
local LUME = require "libs.lume"

---@class FlyingNumber

local M = {}
function  M.fly(lbl,text, from, to, time, fade, fade_delay)
	lbl = gui.clone(lbl)
	gui.set_position(lbl, from)
	gui.set_text(lbl, text)
	gui.animate(lbl,gui.PROP_POSITION,to, gui.EASING_LINEAR, time,0, function()
		gui.delete_node(lbl)
	end)
	if fade then
		local color = gui.get_color(lbl)
		color.w = 0
		gui.animate(lbl,gui.PROP_COLOR,color, gui.EASING_LINEAR, time,fade_delay)
	end
	return lbl
end


return M
