local e = function(world)
	local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
	return {
		{
			text = "Эти люди достигли мира живых. Почтим память тех, кем путникам прилось пожертвовать.",
			buttons = {
				{
					text = "Завершить игру",
					action = "restart"
				}
			}
		}
	}
end

return e
