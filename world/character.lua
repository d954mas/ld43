local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"


---@class Character:Observable
local M = COMMON.class("Character")
M:include(Observable)
local EVENTS = {
    PLAY_ANIMATION = "PLAY_ANIMATION"
}
local STATES = {
    STOP = "STOP",
    WALKING = "WALKING"
}

function M:initialize(art)
    self.EVENTS = EVENTS
    self.STATES = STATES
    self:set_observable_events(self.EVENTS)
    self.art = assert(art)
    self.state = STATES.STOP
end

function M:play_animation()

end

--update animation or other actions if needed
function M:update(dt, no_save)
end


return M