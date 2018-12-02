local COMMON = require "libs.common"

local Char = COMMON.class("CharacterData")
function Char:initialize(data)
    self.art = assert(data.art)
    self.name = data.name or ""
    self.descr = data.descr or ""
    self.id = data.id or ""

    for k,v in pairs(data) do
        self[k] = v
    end
    --events params

    --animations()
    --
end


---@type CharacterData[]
local M = {}

M[1] = Char{art = "char_1", name = "Ангелина", id = "angel"}
M[2] = Char{art = "char_2", name = "Джон", id = "jon"}
M[3] = Char{art = "char_3", name = "Карл", id = "carl"}
M[4] = Char{art = "char_4", name = "Анабель", id = "anabel"}
M[5] = Char{art = "char_5", name = "Роберт", id = "robert"}


return M
