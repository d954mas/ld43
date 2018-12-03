local e = function(world)
  local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return {
    {
      text = name .. "... has found some old cans, they look untouched. It would probably give us a little time. ",
      buttons = {
        {
          text = "Next",
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
