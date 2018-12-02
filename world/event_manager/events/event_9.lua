local e = function(world)
  local char = world:get_char_alive("anabel")
  local random_char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_name = random_char:get_name()
  return
  {
    {
      text = "Неожиданно для всех " .. rand_name .. " падает наземь.\n'Аааййй, как больно. Моя нога!'.\nПохоже, путнику требуется помощь.",
      buttons = {
        char and {
          text = name .. " может быстрее залечить травму (-10 время)",
          action = "close",
          lost = {
            time = 10
          }
        } or {
          text = "Остаться и дождаться, пока боль пройдет (-25 время)",
          action = "close",
          lost = {
            time = 25
          }
        },
        world:count_chars() > 1 and {
          text = "Оставить " .. rand_name .. " и продолжить путь",
          action = "close",
          lost = {
            character = random_char:get_name()
          }
        } or nil
      }
    }
  }
end

return e
