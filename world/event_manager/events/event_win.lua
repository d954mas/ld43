local e = function(world)
	local char = world:get_random_alive_char()
	local name = char and char:get_name() or "CHARACTER_NAME"
	return {
		{
			text = "Those people managed to win the game of Death and return to the world of the living. The sacrifices has been made shouldn't be forgotten.",
			buttons = {
				{
					text = "End the game",
					action = "restart"
				}
			}
		}
	}
end

return e
