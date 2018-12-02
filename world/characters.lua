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

M[1] = Char{art = "char_1", name = "Ангелина", id = "angel", descr = "Просто Астронавт.", positive = {"Спортивная", "Умная"}, negative = {"Арахнофоб", "Самолюбивая"}}
M[2] = Char{art = "char_2", name = "Джон", id = "jon", descr = "Просто боксер.", positive = {"Силач", "Красноречив"}, negative = {"Боязнь высоты", "Карманник"}}
M[3] = Char{art = "char_3", name = "Карл", id = "carl", descr = "Просто художник.", positive = {"Творческий", "Отличный слух"}, negative = {"Слепота", "Обильная доверчивость"}}
M[4] = Char{art = "char_4", name = "Анабель", id = "anabel", descr = "Просто медсестра.", positive = {"Знание медицины", "Навыки вышивания"}, negative = {"Нервная", "Курит"}}
M[5] = Char{art = "char_5", name = "Роберт", id = "robert", descr = "Просто игрок в покер.", positive = {"Ловкий", "Расчетливый"}, negative = {"Недружелюбный", "Обманщик"}}


return M
