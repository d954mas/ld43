local e = function(world)
	local count = world:count_chars()
	local time = 10 * count
	return {
		{
			icon = "1",
			text = "Вы решили остановиться, чтобы поискать пропитание.",
			buttons = {
				{
					text = "Искать. Потратить " .. time .. " времени.",
					action = "close",
					reward = {
						 food = math.random(0, 2 * count)
					},
					lost = {
						time = time
					}
				},
				{
					action = "close",
					text = "Продолжить путь."
				}
			}
		}
	}
end

return e
