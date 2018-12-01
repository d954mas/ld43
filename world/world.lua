local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"
local TAG = "World"

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
	self.characters = {Character("char_1",self),
	Character("char_2",self),
	Character("char_3",self),
	Character("char_4",self),
	Character("char_5",self)}
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

function M:update(dt, no_save)
end

function M:get_character(slot)
	return self.characters[slot]
end


return M()