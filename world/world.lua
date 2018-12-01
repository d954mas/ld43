local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local Character = require "world.character"

---@class World:Observable
local M = COMMON.class("World")
M:include(Observable)
local EVENTS = {
	GOLD_CHANGED = "GOLD_CHANGED",
	SPAWN_ENEMY = "SPAWN_ENEMY",
	ENEMY_DEAD = "ENEMY_DEAD"
}

function M:initialize()
	self.EVENTS = EVENTS
	self:set_observable_events(self.EVENTS)
	self.movement_speed = 100
	self.time = 24 * 60 --minutes
	self.characters = {Character("char_1"),
	Character("char_2"),
	Character("char_3"),
	Character("char_4"),
	Character("char_5")}
end

function M:update(dt, no_save)
end

function M:get_character(slot)
	return self.characters[slot]
end


return M()