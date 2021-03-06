local COMMON = require "libs.common"
local Observable = require "libs.observable_mixin"
local ComplexSubscription = require "libs.complex_subscription"

local SCALE = 0.6
local CHAR_Y = 240
local SIZE = {
    450 * SCALE, 1000 * SCALE
}

---@class Character:Observable
local M = COMMON.class("Character")
M:include(Observable)
local EVENTS = {
    PLAY_ANIMATION = "PLAY_ANIMATION",
    STATE_CHANGED = "STATE_CHANGED",
    POSITION_CHANGED = "POSITION_CHANGED"
}
local STATES = {
    STOP = "STOP",
    WALKING = "WALKING",
    DYING = "DYING",
    DIE = "DIE",
    UPDATE_POS = "UPDATE_POS"
}

---@param world World
---@param data CharacterData
function M:initialize(data, world)
    ---@type CharacterData
    self.data =assert(data)
    self.world = assert(world)
    self.EVENTS = EVENTS
    self.STATES = STATES
    self:set_observable_events(self.EVENTS)
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
    self.rect = {0,CHAR_Y,SIZE[1],SIZE[2]} --x, y, w, h origin in center
end

function M:get_name()
  return self.data.name
end

function M:get_id()
  return self.data.id
end


function M:set_new_pos(pos,speed)
    self.new_pos = pos
    self.movement_speed = speed
    self:set_state(STATES.UPDATE_POS)
end

function M:set_state(state)
    if state ~= STATES.DIE and (self.state == STATES.DYING or self.state == STATES.DIE) then
        return
    end
    assert(STATES[state], "unknown state:" .. state)
    if self.state ~= state then
        COMMON.LOG.w("state changed from:" .. self.state .. " " .. state)
        self.state = state
        self:observable_notify(self.EVENTS.STATE_CHANGED)
    end
end

function M:die()
    if self.STATES ~= STATES.DYING or self.STATES ~= STATES.DIE then
        self:set_state(STATES.DYING)
    end
end

function M:play_animation()
    self:observable_notify(self.EVENTS.PLAY_ANIMATION)
end

function M:is_on_character(x,y)
    x = x/ SCALE - 120
    y = y/ SCALE
    local h_w = self.rect[3]/2
    local h_h = self.rect[4]/2
    if x>= self.rect[1] - h_w and x<= self.rect[1] + h_w
            and y>= self.rect[2] - h_h and y<= self.rect[2] + h_h then
        return true
    end
end

--update animation or other actions if needed
function M:update(dt)
    if self.state == STATES.DYING or self.state == STATES.DIE then
        return
    end
    if self.state == STATES.UPDATE_POS then
        local new_pos = self.rect[1] + self.movement_speed * dt
        if new_pos > self.new_pos then
            new_pos = self.new_pos
            self.new_pos = 0
            self:set_state(STATES.WALKING)
        end
        self:set_position(new_pos)
    end
end

function M:set_position(x)
    self.rect[1] = x
    self:observable_notify(self.EVENTS.POSITION_CHANGED)
end

function M:dispose()
    self.subscription:unsubscribe()
end


return M
