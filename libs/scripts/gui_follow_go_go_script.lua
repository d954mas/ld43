

local COMMON = require "libs.common"
local LUME = require "libs.lume"

---@class FollowGoScriptGo
local Script = COMMON.class("FollowGoScriptGo")


function Script:initialize(url)
	self.url = assert(url, "url can't be nil")
end

function Script:update_position()
	local position = go.get_world_position()
	msg.post(self.url, COMMON.HASHES.MSG_GUI_UPDATE_GO_POS, {position = position})
end


return Script
