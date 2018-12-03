local e = function(world)
	local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
	return {
		{
			icon = "1",
			text = "Ваше время истекло, чтобы продолжить МОЮ игру, я должен забрать одного из вас.",
			buttons = {
				{
					text = "Дальше",
					action = "next",
					value = 2
				}
			}
		},
    {
			icon = "1",
			text = "Вышла смерть из-за тумана, достала ножик из кармана, буду резать, буду бить, заберу я жизнь " .. name .. ".",
			buttons = {
				{
					text = "Дальше",
					action = "close",
					reward = {
            time = 45
          },
          lost = {
            character = char.data.id
          }
				}
			}
		}
	}
end

return e
