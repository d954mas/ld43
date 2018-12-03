local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"
local CHARACTERS = require "world.characters"
local EventManager = require "world.event_manager.event_manager"
local LUME = require "libs.lume"
local TAG = "World"
local TIME_EVENT = require "world.event_manager.events.event_time"
local WIN_EVENT = require "world.event_manager.events.event_win"
local CAMP_EVENT = require "world.event_manager.events.event_camp"

local CHAR_POSITIONS = {
1400,1080,780,480,180
}

local TICK_SPEND_FOOD = 18
local TOTAL_TICKS = 420 --time to move from start to finish
local START_TICKS = 210
local BG_SIZE = 14254
local SPEED = BG_SIZE/TOTAL_TICKS
local ON_CHARACTER_DEAD_TIME = 25
local TIME_TO_EVENT = 50/4
local DT_SCALE = 2
local FADE_IN = 3
local FADE_OUT = 100

---@class World:Observable
local M = COMMON.class("World")
M:include(Observable)
local EVENTS = {
	STATE_CHANGED = "STATE_CHANGED",
	FOOD_CHANGED = "FOOD_CHANGED",
	HUNGRY_CHANGED = "HUNGRY_CHANGED"
}

local STATES = {
	WALK = "WALK",
	EVENT = "EVENT",
	STOP = "STOP",
	HERO_CHOOSE = "HERO_CHOOSE",
	GAME_OVER = "GAME_OVER"
}

function M:initialize()
	self.EVENTS = EVENTS
	self.STATES = STATES
	self.state = STATES.WALK
	self:set_observable_events(self.EVENTS)
	self.movement_speed = SPEED
	self.time = START_TICKS
	self.event_dt = 0
	self.food = 0
	self.hungry = 0
	self.position = 0 --5000
	self.path_lenght = 14254 - 1920
	self.max_time = self.time
	self.food_tick_dt = 0
	---@type Character[]
	self.characters = {Character(CHARACTERS[1],self),
	Character(CHARACTERS[2],self),
	Character(CHARACTERS[3],self),
	Character(CHARACTERS[4],self),
	Character(CHARACTERS[5],self)}
	self:update_positions(true)
	self.event_manager = EventManager()
	self.changing_alpha = FADE_IN
end

function M:change_food(amount)
	if amount == 0 then return end
	local prev_food = self.food
	self.food = math.max(0,self.food + amount)
	self:observable_notify(EVENTS.FOOD_CHANGED,{food = self.food - prev_food})
end

function M:update_positions(force)
	local position = 1
	for i=1,5 do
		local char = self.characters[i]
		if char then
			if force then
				self.characters[i]:set_position(CHAR_POSITIONS[position])
			else
				self.characters[i]:set_new_pos(CHAR_POSITIONS[position],300)
			end
			position = position + 1
		end
	end
end

function M:check_state()
	local characters = self:count_chars()

	if characters == 0 or (self.time <= 0 and characters == 1) then
		self:set_state(STATES.GAME_OVER)
		return
	end

	if self.time <= 0 then
		self:set_state(STATES.EVENT,TIME_EVENT(self))
	end

	if self.state == STATES.WALK and self.position > BG_SIZE-1920 then
		self:set_state(STATES.EVENT, WIN_EVENT(self))
	end
end

function M:set_state(state, state_data)
	assert(STATES[state])
	if self.state == STATES.GAME_OVER then
		return
	end
	if self.state ~= state then
		COMMON.LOG.w("state changed from:" ..  self.state .. " to " .. state )
		self.state = state
		local data
		if self.state == STATES.EVENT then
			self.movement_speed = 0
			data = state_data
		elseif self.state == STATES.WALK then
			self.movement_speed = SPEED
		elseif self.state == STATES.HERO_CHOOSE then
			self.movement_speed = 0
			data = state_data
		elseif self.state == STATES.STOP then
			self.movement_speed = 0
			data = state_data
		end

		self:observable_notify(EVENTS.STATE_CHANGED, data)
	end
end

function M:count_chars()
	local characters = 0
	for i=1,5 do
		local char = self.characters[i]
		if char  and char.state ~= char.STATES.DIE and char.state ~= char.STATES.DYING then
			characters = characters + 1
		end
	end

	return characters
end

function M:get_char_alive(id)
	for i=1,5 do
		local char = self.characters[i]
		if char and char.state ~= char.STATES.DIE and char.state ~= char.STATES.DYING and char:get_id() == id then
			return char
		end
	end
end

function M:get_random_alive_char()
	local characters = { }
	for i=1,5 do
		local char = self.characters[i]
		if char  and char.state ~= char.STATES.DIE and char.state ~= char.STATES.DYING then
			table.insert(characters, char)
		end
	end
	return LUME.randomchoice(characters)
end

function M:char_die(id)
	local char = self:get_char_alive(id)
	if char then
		char:die()
	end
end

function M:set_hungry(val)
	self.hungry = val
	if self.hungry >=2 then
		--kill random character
		local characters = {}
		for i=1,5 do
			local char = self.characters[i]
			if char  and char.state ~= char.STATES.DIE and char.state ~= char.STATES.DYING then
				table.insert(characters,char)
			end
		end
		local char = LUME.randomchoice(characters)
		if char then
			char:die()
		end
	end
	self:observable_notify(EVENTS.HUNGRY_CHANGED)
end

function M:update(dt)
	if self.changing_alpha> 0 then
		self.changing_alpha = self.changing_alpha - dt
		local a = 1- self.changing_alpha/FADE_IN
		model.set_constant("main:/quad#model", "tint0", vmath.vector4(a, a, a, 1))
		return
	end

	dt = dt * DT_SCALE
	self:check_state()
	if self.state == STATES.GAME_OVER then
		return
	end

    if self.state == STATES.WALK then
        self.position = self.position + self.movement_speed * dt
		self.food_tick_dt = self.food_tick_dt + dt
		self.event_dt = self.event_dt + dt
		self.time = self.time - dt
		local eat = false
		if self.food_tick_dt > TICK_SPEND_FOOD then
			self.food_tick_dt = 0
			local spend_food = - self:count_chars()*1
			if math.abs(spend_food) > self.food then
				self:set_hungry(self.hungry +  1)
			else
				self:set_hungry(0)
			end
			self:change_food(spend_food)
			eat = true
		end

		if (self.event_dt >= 1 and not self.first_tutorial) then
			local data = self.event_manager:get_next_event(self)
			self:set_state(STATES.EVENT, data)
			self.first_tutorial = true
		elseif (self.event_dt >= 2 and not self.second_tutorial) then
			local data = self.event_manager:get_next_event(self)
			self:set_state(STATES.EVENT, data)
			self.second_tutorial = true
		end


		--wait for hero die before show new event
		if self.event_dt > TIME_TO_EVENT and not eat then
			self.event_dt = 0
			local data = self.event_manager:get_next_event(self)
			self:set_state(STATES.EVENT, data)
		end
    end
	local need_update_pos = false
	for i=1, 5 do
		local char = self.characters[i]
		if char then
			char:update(dt)
			if char.state == char.STATES.DIE then
				self.characters[i] = nil
				need_update_pos = true
				self.time = math.min(self.max_time, self.time + ON_CHARACTER_DEAD_TIME)
			end
		end
	end

	for i=1, 5 do
		local char = self.characters[i]
		if char then
			if char.state == char.STATES.UPDATE_POS then
				need_update_pos = false
			end
		end
	end


	if need_update_pos then
		self:update_positions()
		--update positions
	end

	local can_move = true
	for i=1, 5 do
		local char = self.characters[i]
		if char then
			if char.state == char.STATES.DYING or char.state == char.STATES.UPDATE_POS then
				if self.state == STATES.WALK or self.state == STATES.STOP then
					self:set_state(STATES.STOP)
					can_move = false
					break
				end
			end
		end
	end

	if can_move and self.state == STATES.STOP then
		self:set_state(STATES.WALK)
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

	if action_id == hash("space") and action.pressed and  self.state == STATES.WALK then
		self:set_state(STATES.EVENT, CAMP_EVENT(self))
	end
end

function M:dispose()
	self:clear()
	self:initialize()
	self.t = nil
end


return M()
