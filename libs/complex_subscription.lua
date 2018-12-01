local COMMON = require "libs.common"

local Subscription = COMMON.class("ComplexSubscription")

function Subscription:initialize()
	self.subscriptions = {}
end

function Subscription:add(subscription)
	assert(subscription)
	assert(subscription.unsubscribe)
	table.insert(self.subscriptions, subscription)
end

function Subscription:unsubscribe()
	for _, subscription in ipairs(self.subscriptions) do
		subscription:unsubscribe()
	end
	self.subscriptions = {}
end

return Subscription