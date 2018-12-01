local COMMON = require "libs.common"

local Char = COMMON.class("CharacterData")
function Char:initialize(art)
    self.art = assert(art)
end


---@type CharacterData[]
local M = {}

M[1] = Char("char_1")
M[2] = Char("char_2")
M[3] = Char("char_3")
M[4] = Char("char_4")
M[5] = Char("char_5")


return M