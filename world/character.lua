local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local ComplexSubscription = require "libs.complex_subscription"


---@class Character:Observable
local M = COMMON.class("Character")
M:include(Observable)
local EVENTS = {
    PLAY_ANIMATION = "PLAY_ANIMATION",
    STATE_CHANGED = "STATE_CHANGED"
}
local STATES = {
    STOP = "STOP",
    WALKING = "WALKING"
}

---@param world World
function M:initialize(art, world)
    self.EVENTS = EVENTS
    self.STATES = STATES
    self.world = world
    self:set_observable_events(self.EVENTS)
    self.art = assert(art)
    self.state = STATES.STOP
    self.subscription = ComplexSubscription()
    self.subscription:add(self.world:register_observer(self.world.EVENTS.STATE_CHANGED, function()
        local state = self.world.state
        if state == self.world.STATES.EVENT then
            self:set_state(STATES.STOP)
        elseif state == self.world.STATES.WALK then
            self:set_state(STATES.WALKING)
        end
    end))
end

function M:set_state(state)
    assert(STATES[state])
    COMMON.LOG.w("state changed from:" .. self.state .. " " .. state)
    if self.state ~= state then
        self.state = state
        self:observable_notify(self.EVENTS.STATE_CHANGED)
    end

end

function M:play_animation()

    self:observable_notify(self.EVENTS.PLAY_ANIMATION)
end

--update animation or other actions if needed
function M:update(dt, no_save)
end

function M:dispose()
    self.subscription:unsubscribe()
end


return M