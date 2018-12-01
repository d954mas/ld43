local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"
local TAG = "World"

local CHAR_POSITIONS = {
1280,980,680,380,80
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
	---@type Character[]
	self.characters = {Character("char_1",self),
	Character("char_2",self),
	Character("char_3",self),
	Character("char_4",self),
	Character("char_5",self)}
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


return M()