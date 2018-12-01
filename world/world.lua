local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"
local CHARACTERS = require "world.characters"
local TAG = "World"

local CHAR_POSITIONS = {
1400,1080,780,480,180
}

---@class World:Observable
local M = COMMON.class("World")
M:include(Observable)
local EVENTS = {
	STATE_CHANGED = "STATE_CHANGED",
}

local STATES = {
	WALK = "WALK",
	EVENT = "EVENT"
}

function M:initialize()
	self.EVENTS = EVENTS
	self.STATES = STATES
	self.state = STATES.WALK
	self:set_observable_events(self.EVENTS)
	self.movement_speed = 100
	self.time = 24 * 60 --minutes
	self.max_time = self.time
	---@type Character[]
	self.characters = {Character(CHARACTERS[1],self),
	Character(CHARACTERS[2],self),
	Character(CHARACTERS[3],self),
	Character(CHARACTERS[4],self),
	Character(CHARACTERS[5],self)}
	self:update_positions()
end

function M:update_positions()
	local position = 1
	for i=1,5 do
		local char = self.characters[i]
		if char then
			self.characters[i]:set_position(CHAR_POSITIONS[position])
			position = position + 1
		end
	end
end

function M:set_state(state)
	assert(STATES[state])
	if self.state ~= state then
		COMMON.LOG.w("state changed from:" ..  self.state .. " to " .. state )
		self.state = state

		if self.state == STATES.EVENT then
			self.movement_speed = 0
		elseif self.state == STATES.WALK then
			self.movement_speed = 50
		end

		self:observable_notify(EVENTS.STATE_CHANGED)
	end
end

function M:update(dt)
	local need_update_pos = false
	for i=1, 5 do
		local char = self.characters[i]
		if char then
			char:update(dt)
			if char.state == char.STATES.DIE then
				self.characters[i] = nil
				need_update_pos = true
			end
		end
	end

	if need_update_pos then
		self:update_positions()
		--update positions
	end
end

function M:set_positions()

end

function M:get_character(slot)
	return self.characters[slot]
end

function M:on_input(action_id, action)
	if action_id == COMMON.HASHES.INPUT_TOUCH and action.pressed then
		for i=1, 5 do
			local char = self.characters[i]
			if char then
				if char:is_on_character(action.x, action.y) then
					COMMON.w("character selected:" .. i)
					return
				end
			end
		end
	end
end


return M()
