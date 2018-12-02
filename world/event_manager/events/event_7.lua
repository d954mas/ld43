local e = function(world)
  local char = world:get_char_alive("angel") or world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return
  {
    {
      text = "Путники находят скелет, рядом с которым лежат мешок и записка. Видно, что кости перебирали, но мешок завязан на узел и не тронут.",
      buttons = {
        {
          text = "Продолжить путь",
          action = "close"
        },
        {
          text = "Открыть мешок",
          action = "next",
          value = 2
        },
        {
          text = "Прочесть записку",
          action = "next",
          value = 3
        }
      }
    },
    {
      text = name .. " решается открыть сумку. Мгновенно из сумки на лицо прыгает огромный паук. Путники в ужасе убегают прочь. Но " .. name .. " не бежит." ,
      buttons = {
        {
          text = "Бежать как можно дальше отсюда",
          action = "close",
          lost = {
            character = char:get_id()
          }
        }
      }
    },
    {
      text = "'Мне нужно бежать, но мешок мешает. Я оставлю его здесь, но в скором времени вернусь. Большая просьба не открывать.'",
      buttons = {
        {
          text = "Открыть сумку",
          action = "next",
          value = 2
        },
        {
          text = "Пойти дальше",
          action = "close"
        }
      }
    }
  }
end

return e
