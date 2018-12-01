local COMMON = require "libs.common"
local LUME = require "libs.lume"
---@class Stepper
local M = COMMON.class("Stepper")

---@class StepSound
---@field duration
---@field sound
---@field delay
---@field gain
local Sound = {
	{duration = 2, sound = "/sounds#step_2" ,delay = {min = 2, max = 6},gain = 1}
}

---@type StepSound[]
local SOUNDS = {
	[{duration = 2, sound = "/sounds#step_1" ,delay = {min = 3, max = 6},gain = 0.1}] = 1,
	[{duration = 2, sound = "/sounds#step_2" ,delay = {min = 3, max = 6},gain = 0.1}] = 1,
	[{duration = 2, sound = "/sounds#step_3" ,delay = {min = 3, max = 6},gain = 0.1}] = 1,
	[{duration = 2, sound = "/sounds#step_4" ,delay = {min = 3, max = 6},gain = 0.1}] = 1,
	[{duration = 2, sound = "/sounds#step_5" ,delay = {min = 3, max = 6},gain = 0.1}] = 1,

}

function M:initialize()
	self.delay = 3
	---@type StepSound[]
	self.sound_list = {}
end

function M:make_sound_list()
	self.sound_list = {}
	local prev_sound = 0
	for i=1,40 do
		local sound
		while not sound or sound==prev_sound do
			sound = LUME.weightedchoice(SOUNDS)
		end
		table.insert(self.sound_list,sound)
	end
end

function M:update(dt)
	self.delay = self.delay - dt
	if self.delay<=0 then
		if #self.sound_list == 0 then
			self:make_sound_list()
		end

		---@type StepSound
		local s = table.remove(self.sound_list)
		sound.play(s.sound, {gain = s.gain} )
		self.delay = math.random(s.delay.min, s.delay.max)
	end
end


return M()
