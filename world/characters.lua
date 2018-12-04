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

M[1] = Char{art = "char_1", name = "Angelina", id = "angel", descr = "Just Astronaut.", positive = {"Sports", "Smart"}, negative = {"Arachnophobia", "Selfish "}}
M[2] = Char{art = "char_2", name = "John", id = "jon", descr = "Just a boxer.", positive = {"Strongman", "Eloquent"}, negative = {"Fear heights ", "Pickpocket "}}
M[3] = Char{art = "char_3", name = "Carl", id = "carl", descr = "Just an artist.", positive = {"Creative", "Excellent hearing"}, negative = {"Blindness", "Plentiful credulity"}}
M[4] = Char{art = "char_4", name = "Anabel", id = "anabel", descr = "Just a nurse.", positive = {"Knowledge of medicine", "Embroidery skills"}, negative = {"Nervous", "Smokes"}}
M[5] = Char{art = "char_5", name = "Robert", id = "robert", descr = "Just a poker player.", positive = {"Dexterous", "Prudent"}, negative = {"Unfriendly", "Deceiver"}}


return M
