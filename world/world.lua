local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"
local CHARACTERS = require "world.characters"
local EventManager = require "world.event_manager.event_manager"
local TAG = "World"

local CHAR_POSITIONS = {
1400,1080,780,480,180
}

---@class World:Observable
local M = COMMON.class("World")
M:include(Observable)
local EVENTS = {
	STATE_CHANGED = "STATE_CHANGED"
}

local STATES = {
	WALK = "WALK",
	EVENT = "EVENT",
	HERO_CHOOSE = "HERO_CHOOSE"
}

function M:initialize()
	self.EVENTS = EVENTS
	self.STATES = STATES
	self.state = STATES.WALK
	self:set_observable_events(self.EVENTS)
	self.movement_speed = 50
	self.time = 24 * 60 --minutes
	self.position = 0
	self.max_time = self.time
	---@type Character[]
	self.characters = {Character(CHARACTERS[1],self),
	Character(CHARACTERS[2],self),
	Character(CHARACTERS[3],self),
	Character(CHARACTERS[4],self),
	Character(CHARACTERS[5],self)}
	self:update_positions()
	self.event_manager = EventManager()
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

function M:set_state(state, state_data)
	assert(STATES[state])
	if self.state ~= state then
		COMMON.LOG.w("state changed from:" ..  self.state .. " to " .. state )
		self.state = state
		local data
		if self.state == STATES.EVENT then
			self.movement_speed = 0
			data = state_data
		elseif self.state == STATES.WALK then
			self.movement_speed = 50
		elseif self.state == STATES.HERO_CHOOSE then
			self.movement_speed = 0
			data = state_data
		end

		self:observable_notify(EVENTS.STATE_CHANGED, data)
	end
end

function M:update(dt)
    if self.state == STATES.WALK then
        self.position = self.position + self.movement_speed * dt
    end
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

	--DEBUG
	if not self.t then
		self.t = 2
	end
	if (self.t > 0) then
		self.t = self.t - dt
	elseif self.state == STATES.WALK then
		local data = self.event_manager:get_next_event()
		self:set_state(STATES.EVENT, data)
		self.t = 100500
	end
	--ENDDEBUG

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
					local data = {
						character = char,
						returned_state = self.state
					}
					self:set_state(STATES.HERO_CHOOSE, data)
					return
				end
			end
		end
	end
end


return M()
