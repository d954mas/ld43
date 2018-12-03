local e = function(world)
	local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
	return {
		{
			icon = "1",
			text = "The time has run out. Death is gonna take someone's life.",
			buttons = {
				{
					text = "Continue",
					action = "next",
					value = 2
				}
			}
		},
    {
			icon = "1",
			text = "Death take " .. name .. ".",
			buttons = {
				{
					text = "Next",
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
