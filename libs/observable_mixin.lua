local LUME = require "libs.lume"

---@class ObservableSubscription
local Subscription = {}
function Subscription:unsubscribe() end

---@class Observable
local M = {
}

function M:set_observable_events(events)
	assert(events, "events can't be nil")
	self._observable_events = events
	self._observable_events_observers={}
	for k,v in pairs(self._observable_events) do
		self._observable_events_observers[v] = {}
	end
end

---@return ObservableSubscription
function M:register_observer(events, fun)
	assert(events, "events can't be nil")
	assert(fun, "url can't be nil")
	assert(fun, "url can't be nil")
	local subscription = {}
	subscription.unsubscribe = function() self:remove_observer(subscription) end
	if type(events) ~= "table" then
		events = {events}
	end
	for i,v in pairs(events) do
		assert(self._observable_events_observers[v], "unknown event:" .. v)
		table.insert(self._observable_events_observers[v], {fun = fun, subscription = subscription})
	end
	return subscription
end


function M:remove_observer(subscription)
	assert(subscription, "url can't be nil")
	for i,subscriptions in pairs(self._observable_events_observers) do
		for i, v in ipairs(subscriptions) do
			if v.subscription == subscription then
				table.remove(subscriptions, i)
				break
			end
		end
	end
end

--[[--take all observers from another observable
function M:migrate_observer(observable)
	self._observable_events = observable.events
	for k,v in pairs(observable._observable_events_observers) do
		self._observable_events_observers[k] = v
		for _, observer in ipairs(self._observable_events_observers[k]) do

		end
	end
end--]]


function M:observable_notify(event, data)
	assert(event, "event can't be nil")
	local event_observables=self._observable_events_observers[event]
	for i=1,#event_observables do
		event_observables[i].fun(self,data,event)
	end
end

function M:clear()
	for i,v in pairs(self._observable_events_observers) do
		LUME.clearp(v)
	end
	self._observable_events = nil
end


return M
