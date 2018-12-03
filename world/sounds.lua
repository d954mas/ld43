local COMMON = require "libs.common"
local LUME = require "libs.lume"
local WORLD = require "world.world"

local M = COMMON.class("Stepper")

local Sounds = {
	{path = 14254/3, sound = "/sounds#blizzard", time=4},
	{path = 14254/3*2, sound = "/sounds#mountains",time = 4 },
	{path = 10000000000, sound = "/sounds#forest",time = 1}
}

local Music = {
    {time = 32, sound = "/sounds#loop"},
    {time = 44, path = 11254/3,sound = "/sounds#loop_1"},
    {time = 64, path = 14254/3*2, sound = "/sounds#loop_2"},
    {time = 64, path = 10000000000, sound = "/sounds#loop_3"}
}

function M:initialize()
end

function M:start()
    self.music_time = 0
	self.current_sound = 1
    self.current_music = 1
	sound.play(Sounds[self.current_sound].sound)
	sound.play(Music[self.current_music].sound)
end

function M:on_message(message_id, message)

end


function M:update(dt)
    self.music_time = self.music_time + dt
	local current_sound = Sounds[self.current_sound]
	if current_sound.path <= WORLD.position then
        local next_sound = Sounds[self.current_sound+1]
		if not self.changind_delta then
			self.changind_delta = 0
            sound.play(next_sound.sound)
		end
		self.changind_delta = self.changind_delta + dt

        local a = LUME.clamp(self.changind_delta/current_sound.time,0,1)
		sound.set_gain(current_sound.sound, 1-a)
		local next_sound = Sounds[self.current_sound+1]
		sound.set_gain(next_sound.sound,a)
		if a == 1 then
			self.current_sound = self.current_sound + 1
			self.changind_delta = nil
		end
	end
end


return M()
