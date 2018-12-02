local COMMON = require "libs.common"
local LUME = require "libs.lume"

--events for build
local common_events = {
	require("world.event_manager.events.event_3"),
	require("world.event_manager.events.event_4"),
	require("world.event_manager.events.event_5"),
	require("world.event_manager.events.event_6"),
	require("world.event_manager.events.event_7")
}

local start_events = {
	require("world.event_manager.events.event_2"),
	require("world.event_manager.events.event_1"),
}

local M = COMMON.class("EventManager")

function M:initialize()
	self.events = { }
	self:fill_common_events()
	for _, v in ipairs(start_events) do
		self:parse_event(v)
	end
end

function M:fill_common_events()
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
	if #self.events <= 0 then
		self:fill_common_events()
	end
  return table.remove(self.events)(world)
end

return M
