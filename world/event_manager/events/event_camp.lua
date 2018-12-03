local e = function(world)
	local count = world:count_chars()
	local time = 10
	return {
		{
			icon = "1",
			text = "You thought if you should search for food.",
			buttons = {
				{
					text = "Search and spend  (" .. time .. " time) on it.",
					action = "close",
					reward = {
						 food = math.random(0, 3 * count)
					},
					lost = {
						time = time
					}
				},
				{
					action = "close",
					text = "Walk further."
				}
			}
		}
	}
end

return e
