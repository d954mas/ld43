local e = function(world)
  local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return {
    {
      character_event = "random",
      icon = "1",
      text = name .. " нашел немного старых консерв. Возможно, вам хватит этого на некоторое время.",
      buttons = {
        {
          text = "Дальше",
          action = "close",
          reward = {
            food = 10
          }
        }
      }
    }
  }
end
