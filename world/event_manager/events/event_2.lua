local e = function(world)
  local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return {
    {
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

return e
