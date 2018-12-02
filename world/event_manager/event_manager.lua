local COMMON = require "libs.common"
local LUME = require "libs.lume"

--events for build
local common_events = {
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
	require("world.event_manager.events.event_1"),
}

local M = COMMON.class("EventManager")

function M:initialize()
	self.events = { }
	for _, v in ipairs(common_events) do
		self:parse_event(v)
	end
  self:shuffle()
end

function M:shuffle()
  LUME.shuffle(self.events)
end

function M:parse_event(event)
  table.insert(self.events, event)
end

function M:get_next_event(world)
  return table.remove(self.events)(world)
end

return M
