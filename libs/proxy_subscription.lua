--USE IT TO CALL SOME EVENTS IN CONTEXT OF GO
local COMMON = require "libs.common"
local ComplexSubscription = require "libs.complex_subscription"

local ProxySubscription = COMMON.class("ProxySubscription")

function ProxySubscription:initialize()
	self.subscription = ComplexSubscription()
	self.events = {}
	self.events_fun = {}
end

function ProxySubscription:add(observable, event, fun, multiple)
	assert(observable)
	assert(event)
	assert(fun)
	assert(not self.events_fun[event], "function for event already included")

	local subscription_fun
	if multiple then
		subscription_fun = function(model,data,event)
			local t = self.events[event] or {}
			table.insert(t, {model = model, data = data, event = event})
		end
	else
		subscription_fun =  function(model,data,event)
			self.events[event] = {{model = model, data = data, event = event}}
		end
	end

	local subscription = observable:register_observer(event,subscription_fun)
	self.events_fun[event] = fun
	self.subscription:add(subscription)
end

function ProxySubscription:act(go_self)
	for k,_ in pairs(self.events) do
		for _,data in ipairs(self.events[k]) do
			self.events_fun[k](go_self,data.model,data.data, data.event)
		end
		self.events[k] = nil
	end
end

function ProxySubscription:clear_events()
	self.events = {}
end

function ProxySubscription:unsubscribe()
	self.subscription:unsubscribe()
	self.events_fun = {}
	self.events = {}
end

return ProxySubscription