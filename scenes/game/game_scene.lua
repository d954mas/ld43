local ProxyScene = require "Jester.proxy_scene"
local Scene = ProxyScene:subclass("GameScene")
local COMMON = require "libs.common"
local SM = require "Jester.scene_stack"
local JESTER = require "Jester.jester"
local WORLD = require "world.world"
local Subscription = require "libs.proxy_subscription"
local STEPPER = require "world.stepper"
local SOUNDS = require "world.sounds"
local EVENTS = require "world.event_manager.event_manager"

function Scene:init_input()
    COMMON.input_acquire()
    self.input_receiver = COMMON.INPUT()
end
--endregion

function Scene:initialize()
    ProxyScene.initialize(self, "GameScene", "/game#proxy", "game:/scene_controller")
    self.msg_receiver = COMMON.MSG()
    self.subscription = Subscription()
end

function Scene:on_show(input)
    math.randomseed(os.time())
    --sound.play("/sounds#wind_ambient", {gain = 0.4} )
    particlefx.play("/particles#snow")
    SOUNDS:start()
   -- WORLD:set_state(WORLD.STATES.EVENT)
  --  local character = WORLD:get_character(1)
    --character:set_state(character.STATES.DYING)
end

function Scene:init(go_self)
    self:init_input()
    msg.post("/game_over_gui#game_over_gui", COMMON.HASHES.MSG_DISABLE)
    self.subscription:add(WORLD, WORLD.EVENTS.STATE_CHANGED, function()
        if WORLD.state == WORLD.STATES.GAME_OVER then
            msg.post("/game_over_gui#game_over_gui", COMMON.HASHES.MSG_ENABLE)
        end
    end)
end

function Scene:final(go_self)
	self.subscription:unsubscribe()
    COMMON.input_release()
    WORLD:dispose()
end

function Scene:update(go_self, dt)
    WORLD:update(dt)
    self.subscription:act(go_self)
    if WORLD.state == WORLD.STATES.WALK then
        STEPPER:update(dt)
    end
    SOUNDS:update(dt)
end

function Scene:show_out(co)
end

function Scene:on_message(go_self, message_id, message, sender)
    self.msg_receiver:on_message(self, message_id, message, sender)
end

function Scene:on_input(go_self, action_id, action, sender)
   self.input_receiver:on_input(go_self,action_id,action,sender)
    WORLD:on_input(action_id,action)
end

function Scene:load(co)
    ProxyScene.load(self,co)
end



--endregion
return Scene